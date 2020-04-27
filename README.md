# Simple Ruby Wrapper to the MaxMind minFraud API

[![Code Climate](https://codeclimate.com/github/kushniryb/minfraud-api-v2/badges/gpa.svg)](https://codeclimate.com/github/kushniryb/minfraud-api-v2)
[![Coverage Status](https://coveralls.io/repos/github/kushniryb/minfraud-api-v2/badge.svg?branch=master)](https://coveralls.io/github/kushniryb/minfraud-api-v2?branch=master)
[![Build Status](https://travis-ci.org/kushniryb/minfraud-api-v2.svg?branch=master)](https://travis-ci.org/kushniryb/minfraud-api-v2)

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

Account ID and License Key are required to work with minFraud API

```ruby
Minfraud.configure do |c|
  c.license_key = 'your_license_key'
  c.user_id     = 'your_user_id'
end
```

## Usage
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

# You can now call 3 different minFraud endpoints: score, insights, factors
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

