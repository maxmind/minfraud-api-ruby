# Minfraud Changelog

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
