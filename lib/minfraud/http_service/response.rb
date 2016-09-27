module Minfraud
  module HTTPService
    class Response
      attr_reader :status
      attr_reader :body
      attr_reader :headers
      attr_reader :code

      def initialize(params)
        @status  = params[:status]
        @body    = params[:body]
        @headers = params[:headers]
      end

      def code
        body.code if body.respond_to?(:code)
      end
    end
  end
end
