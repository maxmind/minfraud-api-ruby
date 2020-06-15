# Simple Ruby Wrapper to the MaxMind minFraud API

[![Code Climate](https://codeclimate.com/github/kushniryb/minfraud-api-v2/badges/gpa.svg)](https://codeclimate.com/github/kushniryb/minfraud-api-v2)
[![Coverage Status](https://coveralls.io/repos/github/kushniryb/minfraud-api-v2/badge.svg?branch=master)](https://coveralls.io/github/kushniryb/minfraud-api-v2?branch=master)
[![Build Status](https://travis-ci.org/kushniryb/minfraud-api-v2.svg?branch=master)](https://travis-ci.org/kushniryb/minfraud-api-v2)

## Description

This package provides an API for the [MaxMind minFraud Score, Insights, Factors
and Report Transaction web services](https://dev.maxmind.com/minfraud/).

Compatible with version minFraud API v2.0

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

Account ID and License Key are required to work with minFraud API

```ruby
Minfraud.configure do |c|
  c.license_key = 'your_license_key'
  c.user_id     = 'your_user_id'
end
```

## Usage

### Score, Insights and Factors

```ruby
# You can either provide a hash of params to the initializer
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

# Some components will raise an error if provided with the wrong values for attributes, e.g
event = Minfraud::Components::Event.new(type: 'foobar') # => Minfraud::NotEnumValueError
# You can check the list of permitted values for the attribute by calling a class method
Minfraud::Components::Event.type_values # => ["account_creation", "account_login", ....]

# You can now call 3 different minFraud endpoints: score, insights and factors
assessment.score
assessment.insights
assessment.factors

result = assessment.score # => Minfraud::Response instance

result.status  # => Response status code
result.code    # => minFraud-specific response code
result.body    # => Mashified body
result.headers # => Response headers

# You can also change data between requests
first_request = assessment.insights
assessment.device.ip_address = '22.22.22.33'
second_request = assessment.insights
```

### Report Transaction

MaxMind encourages the use of this API, as data received through this channel
is continually used to improve the accuracy of their fraud detection algorithms.

To use the Report Transactions API, create a new ` Minfraud::Components::Report::Transaction`
object. An IP address and a valid tag are required arguments for this API.
Additional params may also be set, as documented below.

If the report is successful, nothing is returned. If the report fails, an
exception with be thrown.

See the API documentation for more details.

```ruby
# The report_transaction method only makes use of a transaction component:
txn = Minfraud::Components::Report::Transaction.new(
  ip_address:     '1.2.3.4',
  tag:            :suspected_fraud,
  maxmind_id:     '12345678',
  minfraud_id:    '58fa38d8-4b87-458b-a22b-f00eda1aa20d',
  notes:          'notes go here',
  transaction_id: '1FA254yZ'
)
reporter = Minfraud::Report.new(transaction: txn)
reporter.report_transaction
```

### Exception handling

The Gem supplies several distinct exception-types:

```ruby
# Raised if unpermitted key is provided to Minfraud::Assessments initializer
class RequestFormatError < BaseError; end

# Raised if IP address is absent, reserved or JSON body can not be decoded
class ClientError < BaseError; end

# Raised if there are some problems with the account ID and/or license key
class AuthorizationError < BaseError; end

# Raised if minFraud returns an error, or if there is an HTTP error
class ServerError < BaseError; end

# Raised if an attribute value doesn't belong to the predefined set of values
class NotEnumValueError < BaseError; end
```

## Contributing

Bug reports and pull requests are welcome on GitHub [here](https://github.com/kushniryb/minfraud-api-v2). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

