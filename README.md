# Simple Ruby Wrapper to the MaxMind minFraud API

Compatible with version minFraud API v2.0

[minFraud API documentation](http://dev.maxmind.com/minfraud/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minfraud'
```

And then execute:

```ruby
$ bundle
```

Or install it yourself as:
```
$ gem install minfraud
```

## Configuration

User Id and License Key are required to work with minFraud API

```ruby
Minfraud.configure do |c|
  c.license_key = 'your_license_key'
  c.user_id     = 'your_user_id'
end
```

## Usage
```ruby
Minfraud.configure do |c|
  c.user_id     = 'user_id' # your minFraud user id
  c.license_key = 'license_key' # your minFraud license key
end

# You can either provide a hash of params to initializer
assessment = Minfraud::Assessments.new(
  device: {
    ip_address: '1.2.3.4.5'
  }
)
# or create a component and assign them to assessments object directly, e.g
device = Minfraud::Components::Device.new(ip_address: '1.2.3.4.5')
assessment = Minfraud::Assessments.new(device: device)
# or
assessment = Minfraud::Assessments.new
assessment.device = device


# There are multiple components that reflect minFraud request top level keys
# You can now call 3 different minFraud endpoints: score, insights, factors
assessment.insights
assessment.factors

result = assessment.score # => Minfraud::Response instance

result.status # => Response status code
result.code # => minFraud specific response code
result.body # => Mashified body
result.headers # => Response headers

# You can also change data inbetween requests
first_request = assessment.insights
assessment.device.ip_address = '22.22.22.33'
second_request = assessment.insights
```

### Exception handling

Gem is supplied with four different types of exceptions:
```ruby
# Raised if unpermitted key is provided to Minfraud::Assessments initializer
class RequestFormatError < BaseError; end

# Raised if IP address is absent / it is reserved / JSON body can not be decoded
class ClientError < BaseError; end

# Raised if there are some problems with the user id and / or license key
class AuthorizationError < BaseError; end

# Raised if minFraud returns an error, or if there is an HTTP error
class ServerError < BaseError; end

# Raised if assigned value does not belong to enum list
class NotEnumValueError < BaseError; end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/kushniryb/minfraud-api-v2]. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

