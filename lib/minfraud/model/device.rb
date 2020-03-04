# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Model with information about the device.
    #
    # In order to receive device output from minFraud Insights or minFraud
    # Factors, you must be using the Device Tracking Add-on
    # (https://dev.maxmind.com/minfraud/device/).
    class Device < Abstract
      # This number represents our confidence that the device_id refers to a
      # unique device as opposed to a cluster of similar devices. A confidence
      # of 0.01 indicates very low confidence that the device is unique,
      # whereas 99 indicates very high confidence.
      #
      # @return [Float, nil]
      attr_reader :confidence

      # A UUID that MaxMind uses for the device associated with this IP
      # address. Note that many devices cannot be uniquely identified because
      # they are too common (for example, all iPhones of a given model and OS
      # release). In these cases, the minFraud service will simply not return a
      # UUID for that device.
      #
      # @return [String, nil]
      attr_reader :id

      # This is the date and time of the last sighting of the device. This is
      # an RFC 3339 date-time.
      #
      # @return [String, nil]
      attr_reader :last_seen

      # This is the local date and time of the transaction in the time zone of
      # the device. This is determined by using the UTC offset associated with
      # the device. This is an RFC 3339 date-time
      #
      # @return [String, nil]
      attr_reader :local_time

      # @!visibility private
      def initialize(record)
        super(record)

        @confidence = get('confidence')
        @id = get('id')
        @last_seen = get('last_seen')
        @local_time = get('local_time')
      end
    end
  end
end
