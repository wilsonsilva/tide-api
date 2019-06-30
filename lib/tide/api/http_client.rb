require 'http'
require 'tide/api/response'

module Tide
  module API
    # Responsible for the HTTP interactions. The only entity aware of HTTP concerns such as status codes and headers.
    #
    # @api private
    #
    class HTTPClient
      # An OAuth2 access token
      attr_accessor :access_token

      # An OAuth2 refresh token
      attr_accessor :refresh_token

      # Performs a GET request to Tide's API. Every request returns the status code 200.
      #
      # @example Retrieving a resource
      #   client = HTTPClient.new
      #   result = client.get('https://api.tide.co/tide-backend/rest/api/v1/oauth2/tokens')
      #
      # @param [String] endpoint URL of the API endpoint of the GET request
      #
      # @return [Response] Generic response of a request to Tide's API
      #
      def get(endpoint)
        response = HTTP.headers(headers).get(endpoint)

        Response.new(JSON.parse(response.body), response.status != 200)
      end

      private

      def headers
        return {} if access_token.nil?

        { Authorization: "Bearer #{access_token}" }
      end
    end
  end
end
