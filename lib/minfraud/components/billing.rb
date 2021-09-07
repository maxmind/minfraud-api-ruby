# frozen_string_literal: true

module Minfraud
  module Components
    # Billing corresponds to the billing object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/api-documentation/requests?lang=en#schema--request--billing
    class Billing < Addressable; end
  end
end
