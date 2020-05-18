# Minfraud Changelog

* Adds support for the new credit card output `/credit_card/is_business`.
  This indicates whether the card is a business card. It may be accessed
  via `response.credit_credit.is_business` on the minFraud Insights and
  Factors response objects.
* Adds support for the new email domain output `/email/domain/first_seen`.
  This may be accessed via `response.email.domain.first_seen` on the
  minFraud Insights and Factors response objects.
* Rename ErrorHandler#inspect to ErrorHandler#examine in order not to break LSP.
* Adds classes for the Score, Insights, and Factors responses. This allows
  us to provide API documentation for the various response attributes.
* Removes `hashie` as a required dependency.
* Adds new processor types to `Minfraud::Components::Payment`: `:affirm`,
  `:afterpay`, `:cardpay`, `:ccavenue`, `:cetelem`, `:ct_payments`, `:dalenys`,
  `:datacash`, `:dotpay`, `:ecommpay`, `:epx`, `:g2a_pay`, `:gocardless`,
  `:interac`, `:klarna`, `:mercanet`, `:oney`, `:payeezy`, `:paylike`,
  `:payment_express`, `:paysafecard`, `:posconnect`, `:smartdebit`,
  `:synapsefi`
* Adds `:payout_change` as a type to `Minfraud::Components::Event`

## v1.0.4

* Prevents boolean value conversion to string to avoid warnings
* Adds `amount` attribute to the `Minfraud::Components::Order` instances

## v1.0.3
* Adds `token` attribute to the `Minfraud::Components::CreditCard` instances
according to the MinFraud Release Notes introduced on November 17, 2016

## v1.0.2

* Adds support for Ruby >= 1.9
