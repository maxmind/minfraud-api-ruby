# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**minfraud-api-ruby** is MaxMind's official Ruby client library for the minFraud web services:
- **minFraud Score, Insights, and Factors**: Fraud detection and risk scoring endpoints
- **minFraud Report Transaction API**: Report fraudulent or legitimate transactions

The library provides a request builder pattern through components that are assembled into assessments, then sent to the service endpoints. Responses are returned as strongly-typed model objects.

**Key Technologies:**
- Ruby 3.2+ (uses frozen string literals and modern Ruby features)
- HTTP gem for web service client functionality and persistent connections
- ConnectionPool for thread-safe connection management
- RSpec for testing
- RuboCop with multiple plugins for code quality

## Code Architecture

### Package Structure

```
lib/minfraud/
├── components/         # Request components (Account, Device, Email, etc.)
│   └── report/         # Report Transaction components
├── model/              # Response models (Score, Insights, Factors, etc.)
├── http_service/       # HTTP response wrapper
├── assessments.rb      # Main request builder for Score/Insights/Factors
├── report.rb           # Report Transaction API
├── resolver.rb         # Maps component parameters to component objects
├── enum.rb             # Enum helper for validated attributes
├── validates.rb        # Input validation methods
├── errors.rb           # Custom exceptions
└── version.rb          # Version constant
```

### Key Design Patterns

#### 1. **Component-Based Request Building**

Requests are built using component objects that represent different aspects of a transaction:

```ruby
assessment = Minfraud::Assessments.new(
  device: { ip_address: '1.2.3.4' },
  event: { type: :purchase },
  billing: { country: 'US' },
)
```

**Component Architecture:**
- All components extend `Minfraud::Components::Base`
- Components use `attr_accessor` for attributes
- Components implement `#to_json` to convert to API request format
- The `Resolver` module maps hash parameters to component objects
- Components with enum attributes include `Minfraud::Enum` module

**Resolver Pattern:**
The `Minfraud::Resolver` module handles converting hashes to component objects:
- Maintains a `MAPPING` constant from keys to component classes
- The `#assign` method creates components from hashes or uses existing component objects
- Raises `RequestFormatError` for unknown keys
- Used by `Minfraud::Assessments` in initialization

#### 2. **Enum Attributes with Validation**

Components with restricted value sets use the `Enum` module:

```ruby
class Event < Base
  include ::Minfraud::Enum

  enum_accessor :type, %i[
    account_creation
    purchase
    payout
    recurring_purchase
    referral
    account_login
  ]
end
```

**Key Points:**
- `enum_accessor` creates getter/setter methods with validation
- Values are stored as symbols internally
- Raises `NotEnumValueError` if invalid value assigned
- The class gets a `{attribute}_values` method returning permitted values

#### 3. **Optional Client-Side Validation**

Components can optionally include `Minfraud::Validates` for input validation:

```ruby
class Device < Base
  include ::Minfraud::Validates

  def ip_address=(ip_address)
    validate_ip('ip_address', ip_address) if Minfraud.enable_validation
    @ip_address = ip_address
  end
end
```

**Key Points:**
- Validation is disabled by default
- Enable with `Minfraud.configure { |c| c.enable_validation = true }`
- Validation happens in setters before assignment
- Validates types, formats, lengths, ranges, etc.
- Raises `InvalidInputError` for invalid values

#### 4. **Model Inheritance and Composition**

Response models follow a clear hierarchy:

```
Abstract → Score → Insights → Factors
```

- `Abstract` provides `#get` method for safe hash access
- `Score` has basic risk scoring fields
- `Insights` extends `Score` with detailed fraud data (addresses, phones, device, etc.)
- `Factors` extends `Insights` with subscores and risk reasons

**Model Composition:**
Models compose smaller model objects representing nested data:

```ruby
class Insights < Score
  attr_reader :billing_address
  attr_reader :credit_card
  attr_reader :device
  attr_reader :email

  def initialize(record, locales)
    super
    @billing_address = Minfraud::Model::BillingAddress.new(get('billing_address'))
    @credit_card = Minfraud::Model::CreditCard.new(get('credit_card'))
    # ...
  end
end
```

#### 5. **Connection Pooling for Thread Safety**

The library uses ConnectionPool for thread-safe persistent HTTP connections:

```ruby
@connection_pool = ConnectionPool.new(size: 5) do
  HTTP.basic_auth(user: @account_id, pass: @license_key)
    .persistent("https://#{host}")
end
```

**Key Points:**
- Pool is created in `Minfraud.configure`
- Assessments and Reports use `Minfraud.connection_pool.with { |client| ... }`
- Enables persistent connections without manual management
- Safe for multi-threaded use
- Must call `Minfraud.configure` before using from multiple threads

## Testing Conventions

### Running Tests

```bash
# Install dependencies
bundle install

# Run all tests
bundle exec rake spec

# Run tests and RuboCop
bundle exec rake  # default task

# Run RuboCop only
bundle exec rake rubocop

# Run specific test file
bundle exec rspec spec/assessments_spec.rb

# Run specific test
bundle exec rspec spec/assessments_spec.rb:10
```

### Test Structure

Tests use RSpec and are organized by functionality:
- `spec/assessments_spec.rb` - Main assessment request builder tests
- `spec/report_spec.rb` - Report Transaction API tests
- `spec/components/*_spec.rb` - Component tests
- `spec/model/*_spec.rb` - Response model tests
- `spec/enum_spec.rb` - Enum validation tests
- `spec/http_spec.rb` - HTTP integration tests

### Test Patterns

Tests use RSpec with test data hashes:

```ruby
describe Minfraud::Model::Score do
  let(:raw) do
    {
      'disposition' => { 'action' => 'accept' },
      'funds_remaining' => 10.01,
      'id' => '27d26476-e2bc-11e4-92b8-962e705b4af5',
      'risk_score' => 0.01,
    }
  end

  let(:model) { described_class.new(raw, ['en']) }

  it 'has risk_score' do
    expect(model.risk_score).to eq(0.01)
  end
end
```

When adding new fields:
1. Add field to test data hash
2. Add expectation to verify the field is accessible
3. Test nil handling if field is optional
4. Test validation if applicable

## Working with This Codebase

### Adding New Fields to Components

For input components (request data):

1. **Add an attr_accessor**:
   ```ruby
   # A description of the field.
   #
   # @return [String, nil]
   attr_accessor :new_field
   ```

2. **Add validation if needed**:
   ```ruby
   def new_field=(value)
     validate_string('new_field', 255, value) if Minfraud.enable_validation
     @new_field = value
   end
   ```

3. **Update tests** to include the new field

### Adding New Fields to Models

For output models (response data):

1. **Add an attr_reader** (models are immutable):
   ```ruby
   # A description of the field.
   #
   # @return [Type, nil]
   attr_reader :new_field
   ```

2. **Initialize in constructor**:
   ```ruby
   def initialize(record, locales)
     super
     @new_field = get('new_field')
   end
   ```

3. **For nested objects**, create a model class:
   ```ruby
   @new_field = Minfraud::Model::NewField.new(get('new_field'))
   ```

4. **Update tests** with test data and expectations

### Adding New Enum Values

When adding new values to an enum attribute:

1. **Add to the enum_accessor array**:
   ```ruby
   enum_accessor :type, %i[
     existing_value
     new_value
   ]
   ```

2. **Update CHANGELOG.md** with the new value
3. **Add test** to verify the new value is accepted

### Adding New Components

When creating a new component class:

1. **Extend Base** and include Enum/Validates if needed:
   ```ruby
   class NewComponent < Base
     include ::Minfraud::Enum
     include ::Minfraud::Validates
   end
   ```

2. **Add to Resolver::MAPPING** in lib/minfraud/resolver.rb:
   ```ruby
   MAPPING = {
     new_component: ::Minfraud::Components::NewComponent,
     # ...
   }.freeze
   ```

3. **Add attr_accessor** to Assessments or Report
4. **Require the file** in lib/minfraud.rb
5. **Add tests** for the component

### CHANGELOG.md Format

Always update `CHANGELOG.md` for user-facing changes.

**Important**: Do not add a date to changelog entries until release time.

- If there's an existing version entry without a date (e.g., `v2.9.0`), add your changes there
- If creating a new version entry, don't include a date - it will be added at release time
- Use past tense for descriptions
- Use bullet points starting with `*`

```markdown
## v2.10.0

* Added the `new_field` attribute to `Minfraud::Components::Device`. This
  allows you to provide...
* Added the `/output/path` to the Insights response. This is available
  as the `field_name` attribute on `Minfraud::Model::Insights`.
```

## Common Pitfalls and Solutions

### Problem: Components Not Registering

A new component doesn't work when passed to Assessments.

**Solution**: Make sure you:
1. Added the component to `Resolver::MAPPING`
2. Required the file in lib/minfraud.rb
3. Added the attr_accessor to Assessments or Report

### Problem: Thread Safety Issues

Getting connection errors or state issues in multi-threaded code.

**Solution**:
- Always call `Minfraud.configure` before spawning threads
- Never share `Minfraud::Assessments` or `Minfraud::Report` objects across threads
- Create new Assessment/Report instances per thread

### Problem: Validation Not Working

Validation doesn't catch invalid inputs.

**Solution**:
- Validation is disabled by default
- Enable with `Minfraud.configure { |c| c.enable_validation = true }`
- Make sure the component setter calls the appropriate `validate_*` method

### Problem: Enum Values Rejected

A valid enum value raises `NotEnumValueError`.

**Solution**:
- Enum values must be symbols (`:value` not `"value"`)
- Check the enum_accessor definition includes the value
- Values are case-sensitive

## Code Style Requirements

- **RuboCop enforced** with plugins: performance, rake, rspec, thread_safety
- **Frozen string literals** (`# frozen_string_literal: true`) in all files
- **Target Ruby 3.2+**
- **Max line length: 150 characters**
- **Hash alignment: table style** (aligned rockets and colons)
- **Trailing commas allowed** in arrays, hashes, and arguments
- **Use `if !condition`** instead of `unless condition` (NegatedIf disabled)
- **Metrics cops disabled** - AbcSize, ClassLength, MethodLength, etc.

Key RuboCop configurations:
- Guard clauses not enforced
- Conditional assignment not enforced
- Format string token checks disabled
- Multiple assertions allowed in RSpec tests
- Extra spacing with force equal sign alignment enabled

## Development Workflow

### Setup
```bash
bundle install
```

### Before Committing
```bash
# Run tests and linting
bundle exec rake

# Or run separately
bundle exec rake spec
bundle exec rake rubocop
```

### Running Single Test
```bash
bundle exec rspec spec/assessments_spec.rb
```

### Testing Against Sandbox
```ruby
Minfraud.configure do |c|
  c.account_id = 12345
  c.license_key = 'your_license_key'
  c.host = 'sandbox.maxmind.com'
end
```

### Version Requirements
- **Ruby 3.2+** required
- Target compatibility should match current supported Ruby versions

## API Endpoints

The library supports three assessment endpoints:
- `assessment.score` - Basic risk score (Score model)
- `assessment.insights` - Score + detailed fraud data (Insights model)
- `assessment.factors` - Insights + subscores + risk reasons (Factors model)

Report Transaction API:
- `reporter.report_transaction` - Report transaction outcomes

## Additional Resources

- [API Documentation](https://www.rubydoc.info/gems/minfraud)
- [minFraud Web Services Docs](https://dev.maxmind.com/minfraud)
- [Report Transaction API Docs](https://dev.maxmind.com/minfraud/report-a-transaction)
- GitHub Issues: https://github.com/maxmind/minfraud-api-ruby/issues
