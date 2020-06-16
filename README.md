# Ruby API for MaxMind minFraud Services

[![Code
Climate](https://codeclimate.com/github/maxmind/minfraud-api-ruby/badges/gpa.svg)](https://codeclimate.com/github/maxmind/minfraud-api-ruby)
[![Coverage
Status](https://coveralls.io/repos/github/maxmind/minfraud-api-ruby/badge.svg?branch=master)](https://coveralls.io/github/maxmind/minfraud-api-ruby?branch=master)
[![Build
Status](https://travis-ci.org/maxmind/minfraud-api-ruby.svg?branch=master)](https://travis-ci.org/maxmind/minfraud-api-ruby)

## Description

This package provides an API for the [MaxMind minFraud web
services](https://dev.maxmind.com/minfraud/). This includes minFraud Score,
Insights, and Factors. It also includes our [minFraud Report Transaction
API](https://dev.maxmind.com/minfraud/report-transaction/).

The legacy minFraud Standard and Premium services are not supported by this
API.

## Requirements

This gem works with Ruby 1.9 and above.

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

## Usage

### Configuration

An account ID and license key are required to work with the web services.

```ruby
Minfraud.configure do |c|
  c.license_key = 'your_license_key'
  c.user_id     = 'your_user_id'
end
````

### Making a minFraud Score, Insights, or Factors Request

```ruby
# You can either provide a hash of parameters to the initializer
assessment = Minfraud::Assessments.new(
  device: {
    ip_address: '1.2.3.4.5'
  }
)
# or create a component and assign them to the assessments object directly
device = Minfraud::Components::Device.new(ip_address: '1.2.3.4.5')
assessment = Minfraud::Assessments.new(device: device)
# or
assessment = Minfraud::Assessments.new
assessment.device = device

# There are multiple components that reflect the minFraud request top level
# keys.

# Some components will raise an error if provided with the wrong values for
# attributes, e.g
event = Minfraud::Components::Event.new(type: 'foobar') # => Minfraud::NotEnumValueError

# You can check the list of permitted values for the attribute by calling a
# class method
Minfraud::Components::Event.type_values # => ["account_creation", "account_login", ....]

# You can now call 3 different minFraud endpoints: score, insights and factors
assessment.score
assessment.insights
assessment.factors

result = assessment.score # => Minfraud::Response instance

result.status  # => Response status code
result.code    # => minFraud-specific response code
result.body    # => Response body
result.headers # => Response headers

# You can change data between requests
first_request = assessment.insights
assessment.device.ip_address = '22.22.22.33'
second_request = assessment.insights
```

See the [API documentation](https://www.rubydoc.info/gems/minfraud) for
more details.

### Reporting a Transaction to MaxMind

MaxMind encourages the use of this API, as data received through this
channel is continually used to improve the accuracy of their fraud
detection algorithms.

To use the Report Transactions API, create a new
`Minfraud::Components::Report::Transaction` object. An IP address and a
valid tag are required arguments for this API. Additional params may also
be set, as documented below.

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

See the [API documentation](https://www.rubydoc.info/gems/minfraud) for
more details.

### Exceptions

The gem supplies several distinct exception-types:

* `RequestFormatError` - Raised if unpermitted key is provided to the
  `Minfraud::Assessments` initializer
* `ClientError` - Raised if the IP address is absent, reserved or JSON body
  can not be decoded
* `AuthorizationError` - Raised if there are problems with the account ID
  and/or license key
* `ServerError` - Raised if minFraud returns an error, or if there is an
  HTTP error
* `NotEnumValueError` - Raised if an attribute value doesn't belong to the
  predefined set of values

## Support

Please report all issues with this code using the
[GitHub issue tracker](https://github.com/maxmind/minfraud-api-ruby/issues).

If you are having an issue with the minFraud service that is not specific
to the client API, please see
[our support page](https://www.maxmind.com/en/support).

## Contributing

Bug reports and pull requests are welcome on GitHub
[here](https://github.com/maxmind/minfraud-api-ruby). This project is
intended to be a safe, welcoming space for collaboration, and contributors
are expected to adhere to the [Contributor
Covenant](https://contributor-covenant.org) code of conduct.

## Versioning

This API uses [Semantic Versioning](https://semver.org/).

## Copyright and License

Copyright (c) 2016-2020 kushnir.yb.

Copyright (c) 2020 MaxMind, Inc.

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

## Thank You

This gem is the work of the creator and original maintainer kushnir.yb
(@kushniryb).
