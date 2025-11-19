# Changelog

## v2.9.0

* Added the processor `:securepay` to `Minfraud::Components::Payment`.
* Ruby 3.2+ is now required. If you're using Ruby 3.0 or 3.1, please use
  version 2.8.0 of this gem.
* Added `/event/type` values `:credit_application` and `:fund_transfer` to
  `Minfraud::Components::Event`.
* Added the `/event/type` value `:sim_swap` to
  `Minfraud::Components::Event`.
* Added the input `/event/party`. This is the party submitting the
  transaction. You may provide this using the `party` attribute on
  `Minfraud::Components::Event`.
* Added the input `/payment/method`. This is the payment method associated
  with the transaction. You may provide this using the `method` attribute
  on `Minfraud::Components::Payment`.
* Added support for new email domain outputs on `Minfraud::Model::EmailDomain`:
  * `/email/domain/classification` - The domain type (e.g., business,
    education, government, isp_email). Available as the `classification`
    attribute.
  * `/email/domain/risk` - A risk score from 0.01 to 99 for the domain.
    Available as the `risk` attribute.
  * `/email/domain/volume` - Activity across the minFraud network expressed
    as sightings per million. Available as the `volume` attribute.
  * `/email/domain/visit` - Information from an automated visit to the
    domain. Available as the `visit` attribute, which returns a
    `Minfraud::Model::EmailDomainVisit` object.
* Added support for email domain visit outputs on
  `Minfraud::Model::EmailDomainVisit`:
  * `/email/domain/visit/has_redirect` - Whether the domain redirects to
    another URL. Available as the `has_redirect` attribute.
  * `/email/domain/visit/last_visited_on` - The date the automated visit
    was completed. Available as the `last_visited_on` attribute.
  * `/email/domain/visit/status` - The status of the domain (e.g., live,
    dns_error, parked). Available as the `status` attribute.

## v2.8.0 (2025-05-23)

* Added support for the `/billing_phone/matches_postal` and
  `/shipping_phone/matches_postal` outputs. These are available as the
  `matches_postal` attribute on `Minfraud::Model::Phone`.
* Added the processor `:cryptomus` to `Minfraud::Components::Payment`.

## v2.7.1 (2025-02-10)

* Re-release due to bug in release workflow.

## v2.7.0 (2025-02-10)

* The minFraud Factors subscores have been deprecated. They will be removed
  in March 2025. Please see [our release notes](https://dev.maxmind.com/minfraud/release-notes/2024/#deprecation-of-risk-factor-scoressubscores)
  for more information.
* Ruby 3.0+ is now required. If you're using Ruby 2.7, please use version
  2.7.0.beta1 or 2.6.0 of this gem.
* Added the processor `:epayco` to `Minfraud::Components::Payment`.

## v2.7.0.beta1 (2024-09-06)

* Added support for the new risk reasons outputs in minFraud Factors. The risk
  reasons output codes and reasons are currently in beta and are subject to
  change. We recommend that you use these beta outputs with caution and avoid
  relying on them for critical applications.

## v2.6.0 (2024-07-08)

* Updated the validation for the Report Transactions API to make the
  `ip_address` parameter optional. Now the `tag` and at least one of the
  following parameters must be supplied: `ip_address`, `maxmind_id`,
  `minfraud_id`, `transaction_id`.
* Updated the validation for the Report Transactions API to check that
  `ip_address`, `maxmind_id`, and `minfraud_id` contain valid values.
* Added `billing_phone` and `shipping_phone` attributes to the minFraud
  Insights and Factors response models. These contain objects with
  information about the respective phone numbers. Please see [our developer
  site](https://dev.maxmind.com/minfraud/api-documentation/responses/) for
  more information.
* Added the processor `:payconex` to `Minfraud::Components::Payment`.

## v2.5.0 (2024-04-16)

* Equivalent domain names are now normalized when `hash_address` is used.
  For example, `googlemail.com` will become `gmail.com`.
* Periods are now removed from `gmail.com` email address local parts when
  `hash_address` is used. For example, `f.o.o@gmail.com` will become
  `foo@gmail.com`.
* Fastmail alias subdomain email addresses are now normalized when
  `hash_address` is used. For example, `alias@user.fastmail.com` will
  become `user@fastmail.com`.
* Additional `yahoo.com` email addresses now have aliases removed from
  their local part when `hash_address` is used. For example,
  `foo-bar@yahoo.com` will become `foo@yahoo.com` for additional
  `yahoo.com` domains.
* Duplicate `.com`s are now removed from email domain names when
  `hash_address` is used. For example, `example.com.com` will become
  `example.com`.
* Certain TLD typos are now normalized when `hash_address` is used. For
  example, `example.comcom` will become `example.com`.
* Additional `gmail.com` domain names with leading digits are now
  normalized when `hash_address` is used. For example, `100gmail.com` will
  become `gmail.com`.
* Additional `gmail.com` typos are now normalized when `hash_address` is
  used. For example, `gmali.com` will become `gmail.com`.
* When `hash_address` is used, all trailing periods are now removed from an
  email address domain. Previously only a single period was removed.
* When `hash_address` is used, the local part of an email address is now
  normalized to NFC.

## v2.4.0 (2024-01-12)

* Ruby 2.7+ is now required. If you're using Ruby 2.5 or 2.6, please use
  version 2.3.0 of this gem.
* Added the processors `:pxp_financial` and `:trustpay` to
  `Minfraud::Components::Payment`.

## v2.3.0 (2023-12-04)

* Added the processor `:shopify_payments` to `Minfraud::Components::Payment`.
* Added the processor `:google_pay` to `Minfraud::Components::Payment`.
* Added the processor `:placetopay` to `Minfraud::Components::Payment`.
* In addition to the minfraud gem version, the User-Agent now includes the
  version of Ruby and the version of the HTTP client in all HTTP requests.
* Updated `maxmind-geoip2` to version that includes the `anycast?` method
  on `MaxMind::GeoIP2::Record::Traits`. This returns `true` if the IP
  address belongs to an [anycast
  network](https://en.wikipedia.org/wiki/Anycast). This is available in
  minFraud Insights and Factors.

## v2.2.0 (2022-03-28)

* Added the input `/credit_card/country`. This is the country where the
  issuer of the card is located. This may be passed instead of the
  `/credit_card/issuer_id_number` if you do not wish to pass partial
  account numbers or if your payment processor does not provide them. You
  may provide this using the `country` attribute on
  `Minfraud::Components::CreditCard`.

## v2.1.0 (2022-01-25)

* Adds the following new processor to `Minfraud::Components::Payment`:
  * `:windcave`
* The `last_4_digits` input to `Minfraud::Components::CreditCard` has been
  deprecated in favor of `last_digits` and will be removed in a future
  release. `last_digits`/`last_4_digits` also now supports two digit values
  in addition to the previous four digit values.
* Eight digit `issuer_id_number` inputs are now supported by
  `Minfraud::Components::CreditCard` in addition to the previously accepted
  six digit `issuer_id_number`. In most cases, you should send the last four
  digits for `last_digits`. If you send an `issuer_id_number` that contains
  an eight digit IIN, and if the credit card brand is not one of the
  following, you should send the last two digits for `last_digits`:
  * `Discover`
  * `JCB`
  * `Mastercard`
  * `UnionPay`
  * `Visa`

## v2.0.0 (2021-12-06)

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
* Breaking change from 1.x: Removed deprecated method for deprecated
  attribute `ip_address.country.is_high_risk`.
* Breaking change from 1.x: Switches HTTP client from faraday to http.rb.
  There should be no behavior change for most users, but this is
  technically a breaking change from the perspective of semver. Most users
  should not be affected as the changes are limited to attributes and
  classes that would not normally be accessed outside the gem.
* Breaking change from 1.x: `user_id` is no longer supported as a way to
  configure your MaxMind account ID. Use `account_id` instead.
* Breaking change from 1.x: Removed the `Minfraud.configuration` method.
* Breaking change from 1.x: Localized names are no longer exposed via
  methods on `names` objects, only as hash keys. For example, use
  `response.ip_address.country.names['en']` instead of
  `response.ip_address.country.names.en`. The latter was deprecated.
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
* Depend on the `maxmind-geoip2` gem. This allows us to delete classes from
  that gem that we previously had included in this gem. There is no
  functional difference.

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

* Adds the `hash_address` attribute to `Minfraud::Components::Email`. If
  this is `true`, the MD5 hash of the `address` will be sent instead of the
  plain text `address`. Use this if you prefer to send the hash of the
  `address` rather than the plain text. Note that this normalizes the
  `address`, so we recommend using it as opposed to hashing the `address`
  manually.
* The email `domain` input is now automatically set if the email `address`
  input is set but the `domain` is not.
* Adds new payment processors `:apple_pay` and `:aps_payments` to
  `Minfraud::Components::Payment`.
* Adds support for the IP address risk reasons in the minFraud Insights
  and Factors responses. This is available at `.ip_address.risk_reasons`.
  It is an array of `IPRiskReason` objects.

## v1.4.1 (2020-12-01)

* Do not throw an exception if the response does not include IP address
  information. Previously we would incorrectly try to retrieve fields from
  `nil`, leading to a `NoMethodError`.

## v1.4.0 (2020-10-13)

* IMPORTANT: Ruby 2.0 is no longer supported. If you're using Ruby 2.0,
  please use version 1.3.0.
* Adds handling for the `REQUEST_INVALID` error code.
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
