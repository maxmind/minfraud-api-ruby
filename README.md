# Ruby API for MaxMind minFraud Services

## Description

This package provides an API for the [MaxMind minFraud web
services](https://dev.maxmind.com/minfraud/). This includes minFraud Score,
Insights, and Factors. It also includes our [minFraud Report Transaction
API](https://dev.maxmind.com/minfraud/report-transaction/).

The legacy minFraud Standard and Premium services are not supported by this
API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minfraud'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install minfraud
```

## API Documentation

See the [API documentation](https://www.rubydoc.info/gems/minfraud) for
more details.

## Usage

### Configuration

An account ID and license key are required to work with the web services.
Configure these before making a request:

```ruby
Minfraud.configure do |c|
  c.account_id  = 12345
  c.license_key = 'your_license_key'
end
````

### Making a minFraud Score, Insights, or Factors Request

To use the minFraud API, create a `Minfraud::Assessments` object. The
constructor takes a hash of symbols corresponding to each component of the
minFraud request. You can also set components by their attribute after
creating the object.

After populating the object, call the method for the minFraud endpoint you
want to use: `#score`, `#insights`, or `#factors`. The returned value is a
`MinFraud::Response` object. You can access the response model through its
`#body` attribute.

An exception will be thrown for critical errors. You should check for
`warnings` related to your inputs after a request.

```ruby
# Prepare the request.
assessment = Minfraud::Assessments.new(
  device: {
    ip_address:      '152.216.7.110',
    accept_language: 'en-US,en;q=0.8',
    session_age:     3600.5,
    session_id:      'foo',
    user_agent:      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36',
  },
  event: {
    transaction_id: 'txn3134133',
    shop_id:        's2123',
    time:           '2012-04-12T23:20:50+00:00',
    type:           :purchase,
  },
  account: {
    user_id:      '3132',
    username_md5: '4f9726678c438914fa04bdb8c1a24088',
  },
  email: {
    address: 'test@maxmind.com',
    domain:  'maxmind.com',
  },
  billing: {
    first_name:         'First',
    last_name:          'Last',
    company:            'Company',
    address:            '101 Address Rd.',
    address_2:          'Unit 5',
    city:               'New Haven',
    region:             'CT',
    country:            'US',
    postal:             '06510',
    phone_number:       '323-123-4321',
    phone_country_code: '1',
  },
  shipping: {
    first_name:         'ShipFirst',
    last_name:          'ShipLast',
    company:            'ShipCo',
    address:            '322 Ship Addr. Ln.',
    address_2:          'St. 43',
    city:               'Nowhere',
    region:             'OK',
    country:            'US',
    postal:             '73003',
    phone_number:       '403-321-2323',
    phone_country_code: '1',
    delivery_speed:     :same_day,
  },
  payment: {
    processor:      :stripe,
    was_authorized: false,
    decline_code:   'invalid number',
  },
  credit_card: {
    issuer_id_number:        '323132',
    last_4_digits:           '7643',
    bank_name:               'Bank of No Hope',
    bank_phone_country_code: '1',
    bank_phone_number:       '800-342-1232',
    token:                   'abcd',
    avs_result:              'Y',
    cvv_result:              'N',
  },
  order: {
    amount:           323.21,
    currency:         'USD',
    discount_code:    'FIRST',
    is_gift:          true,
    has_gift_message: false,
    affiliate_id:     'af12',
    subaffiliate_id:  'saf42',
    referrer_uri:     'http://www.amazon.com/',
  },
  shopping_cart: [
    {
      category: 'pets',
      item_id:  'leash-0231',
      quantity: 2,
      price:    20.43,
    },
    {
      category: 'beauty',
      item_id:  'msc-1232',
      quantity: 1,
      price:    100.00,
    },
  ],
  custom_inputs: {
    section:            'news',
    previous_purchases: 19,
    discount:           3.2,
    previous_user:      true,
  },
)

# To get the Factors response model, use #factors.
factors_model = assessment.factors.body

factors_model.warnings.each { |w| puts w.warning }

p factors_model.subscores.email_address
p factors_model.risk_score

# To get the Insights response model, use #insights.
insights_model = assessment.insights.body

insights_model.warnings.each { |w| puts w.warning }

p insights_model.credit_card.issuer.name
p insights_model.risk_score

# To get the Score response model, use #score.
score_model = assessment.score.body

score_model.warnings.each { |w| puts w.warning }

p score_model.risk_score
```

See the [API documentation](https://www.rubydoc.info/gems/minfraud) for
more details.

### Reporting a Transaction to MaxMind

MaxMind encourages the use of this API, as data received through this
channel is used to improve the accuracy of their fraud detection
algorithms.

To use the Report Transaction API, create a
`Minfraud::Components::Report::Transaction` object. An IP address and a
valid tag are required arguments for this API. Additional parameters may be
set, as shown below.

If the report is successful, nothing is returned. If the report fails, an
exception will be thrown.

```ruby
# The report_transaction method only makes use of a transaction component:
txn = Minfraud::Components::Report::Transaction.new(
  ip_address:     '152.216.7.110',
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

### Persistent HTTP Connections

This gem supports persistent HTTP connections, allowing you to avoid the
overhead of creating a new HTTP connection for each minFraud request if you
plan to perform more than one. You do not need to do anything to enable
this functionality.

### Exceptions

The gem supplies several distinct exception-types:

* `RequestFormatError` - Raised if an unknown key is provided to the
  `Minfraud::Assessments` constructor
* `ClientError` - Raised if the IP address is absent, reserved, or the JSON
  body cannot be decoded
* `AuthorizationError` - Raised if there are problems with the account ID
  and/or license key
* `ServerError` - Raised if minFraud returns an error or if there is an
  HTTP error
* `NotEnumValueError` - Raised if an attribute value doesn't belong to the
  predefined set of values

### Thread Safety

This gem is safe for use from multiple threads.

`Minfraud::Assessments` and `Minfraud::Report` objects must not be shared
across threads.

Please note that you must run `Minfraud.configure` before calling any
functionality using multiple threads.

## Support

Please report all issues with this code using the
[GitHub issue tracker](https://github.com/maxmind/minfraud-api-ruby/issues).

If you are having an issue with the minFraud service that is not specific
to the client API, please see
[our support page](https://www.maxmind.com/en/support).

## Requirements

This gem works with Ruby 2.0 and above.

## Contributing

Bug reports and pull requests are welcome on
[GitHub](https://github.com/maxmind/minfraud-api-ruby). This project is
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
