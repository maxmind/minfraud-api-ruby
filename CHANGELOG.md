# Minfraud Changelog

## v1.2.0

* Adds new processor types to `Minfraud::Components::Payment`: `:cashfree`,
  `:first_atlantic_commerce`, `:komoju`, `:paytm`, `:razorpay`, and
  `:systempay`.
* Adds support for the new Factors outputs `/subscores/device`,
  `/subscores/email_local_part` and `/subscores/shipping_address`

## v1.1.0 (2020-06-19)

* Adds support for the minFraud Report Transaction API. Reporting
  transactions to MaxMind helps us detect about 10-50% more fraud and
  reduce false positives for you.
* Adds support for the new credit card output `/credit_card/is_business`.
  This indicates whether the card is a business card. It may be accessed
  via `response.credit_credit.is_business` on the minFraud Insights and
  Factors response objects.
* Adds support for the new email domain output `/email/domain/first_seen`.
  This may be accessed via `response.email.domain.first_seen` on the
  minFraud Insights and Factors response objects.
* Rename `ErrorHandler#inspect` to `ErrorHandler#examine` in order not to
  break LSP.
* Adds classes for the Score, Insights, and Factors responses. This allows
  us to provide API documentation for the various response attributes.
* Removes `hashie` as a required dependency.
* Adds new processor types to `Minfraud::Components::Payment`: `:affirm`,
  `:afterpay`, `:cardpay`, `:ccavenue`, `:cetelem`, `:ct_payments`,
  `:dalenys`, `:datacash`, `:dotpay`, `:ecommpay`, `:epx`, `:g2a_pay`,
  `:gocardless`, `:interac`, `:klarna`, `:mercanet`, `:oney`, `:payeezy`,
  `:paylike`, `:payment_express`, `:paysafecard`, `:posconnect`,
  `:smartdebit`, `:synapsefi`, and others.
* Adds support for passing custom inputs to minFraud. GitHub #6.
* Adds `:email_change`, `:password_reset`, and `:payout_change` as types to
  `Minfraud::Components::Event`.
* Adds support for the `session_id` and `session_age` inputs.

## v1.0.4 (2016-12-23)

* Prevents boolean value conversion to string to avoid warnings
* Adds `amount` attribute to the `Minfraud::Components::Order` instances

## v1.0.3 (2016-11-24)
* Adds `token` attribute to the `Minfraud::Components::CreditCard` instances
according to the MinFraud Release Notes introduced on November 17, 2016

## v1.0.2 (2016-10-11)

* Adds support for Ruby >= 1.9
