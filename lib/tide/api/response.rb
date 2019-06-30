module Tide
  module API
    # Generic response of a request to Tide's API
    #
    # @api private
    #
    class Response
      # Hash or array of hashes representing each item in the response body.
      #
      # @return [Hash|Array<Hash>]
      #
      attr_reader :payload

      # Instantiates a new API response
      #
      # @param [Hash|Array<Hash>] payload Hash or array of hashes representing each item in the response body.
      # @param [Boolean] error Whether the request failed
      #
      def initialize(payload, error)
        @payload = payload
        @error = error
      end

      # Whether the response contains errors
      #
      # @return [Boolean] true if the response has errors and false otherwise
      #
      def error?
        @error
      end
    end
  end
end
