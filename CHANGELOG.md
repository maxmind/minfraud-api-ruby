# Minfraud Changelog

## v2.0.0

* Breaking change from 1.x: Removed deprecated methods
  `is_in_european_union`, `is_anonymous`, `is_anonymous_vpn`,
  `is_hosting_provider`, `is_public_proxy`, and `is_tor_exit_node`. The
  non-deprecated equivalents are `in_european_union?`, `anonymous?`,
  `anonymous_vpn?`, `hosting_provider?`, `public_proxy?`, and
  `tor_exit_node?`.
* Breaking change from 1.x: Removed deprecated methods for deprecated
  subscores: `email_tenure` and `ip_tenure`. For `email_tenure`, please use
  the `email_address` subscore instead. For `ip_tenure`, please use
  `risk_score` instead.
* Breaking change from 1.x: Switches HTTP client from faraday to http.rb.
  There should be no behavior change for most users, but this is
  technically a breaking change from the perspective of semver. Most users
  should not be affected as the changes are limited to attributes and
  classes that would not normally be accessed outside the gem.
* Adds mobile country code (MCC) and mobile network code (MNC) to minFraud
  Insights and Factors responses. These are available at
  `response.ip_address.traits.mobile_country_code` and
  `response.ip_address.traits.mobile_network_code`. We expect this data to
  be available by late January, 2022.
* Adds the following new processors to `Minfraud::Components::Payment`:
  * `:boacompra`
  * `:boku`
  * `:coregateway`
  * `:fiserv`
  * `:neopay`
  * `:neosurf`
  * `:openbucks`
  * `:paysera`
  * `:payvision`
  * `:trustly`

## v1.6.0 (2021-08-19)

* Adds new processor to `Minfraud::Components::Payment`: `:cardknox`,
  `:creditguard`, `:credorax`, `:datacap`, `:dlocal`, `:onpay`, and
  `:safecharge`.
* Adds `rule_label` to minFraud output `/disposition`.
* Adds support for the `/credit_card/was_3d_secure_successful` input. This is
  available by setting the `was_3d_secure_successful` attribute on
  `Minfraud::Components::CreditCard`.
* Ruby 2.5+ is now required. If you're using Ruby 2.1, 2.2, 2.3, or 2.4,
  please use version 1.5.0 of this gem.

## v1.5.0 (2021-02-02)

* Add the `hash_address` attribute to `Minfraud::Components::Email`. If
  this is `true`, the MD5 hash of the `address` will be sent instead of the
  plain text `address`. Use this if you prefer to send the hash of the
  `address` rather than the plain text. Note that this normalizes the
  `address`, so we recommend using it as opposed to hashing the `address`
  manually.
* The email `domain` input is now automatically set if the email `address`
  input is set but the `domain` is not.
* Adds new payment processors `:apple_pay` and `:aps_payments` to
  `Minfraud::Components::Payment`.
* Added support for the IP address risk reasons in the minFraud Insights
  and Factors responses. This is available at `.ip_address.risk_reasons`.
  It is an array of `IPRiskReason` objects.

## v1.4.1 (2020-12-01)

* Do not throw an exception if the response does not include IP address
  information. Previously we would incorrectly try to retrieve fields from
  `nil`, leading to a `NoMethodError`.

## v1.4.0 (2020-10-13)

* IMPORTANT: Ruby 2.0 is no longer supported. If you're using Ruby 2.0,
  please use version 1.3.0.
* Add handling for the `REQUEST_INVALID` error code.
* The IP address is no longer a required input.
* Adds new payment processor `:tsys` to `Minfraud::Components::Payment`.

## v1.3.0 (2020-09-25)

* Adds support for persistent HTTP connections. Connections persist
  automatically.
* IMPORTANT: Ruby 1.9 is no longer supported. If you're using Ruby 1.9,
  please use version 1.2.0 or older.
* Adds support for client side validation of inputs. An `InvalidInputError`
  exception will be raised if an input is invalid. This can be enabled by
  setting `enable_validation` to `true` when configuring `Minfraud`. It is
  disabled by default.
* Adds the `residential_proxy?` method to `MaxMind::GeoIP2::Record::Traits`
  for use with minFraud Insights and Factors.

## v1.2.0 (2020-07-15)

* Adds new processor types to `Minfraud::Components::Payment`: `:cashfree`,
  `:first_atlantic_commerce`, `:komoju`, `:paytm`, `:razorpay`, and
  `:systempay`.
* Adds support for three new Factors outputs: `/subscores/device` (the risk
  associated with the device), `/subscores/email_local_part` (the risk
  associated with the part of the email address before the @ symbol) and
  `/subscores/shipping_address` (the risk associated with the shipping
  address).
* Adds support for providing your MaxMind account ID using the `account_id`
  attribute instead of the `user_id` attribute. In a future release,
  support for the `user_id` attribute will be removed.

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
