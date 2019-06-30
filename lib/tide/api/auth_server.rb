# typed: true
require 'socket'

module Tide
  module API
    # Receives an authorization grant code from the OAuth2 callback.
    class AuthServer
      # This is the ID shown in the authorization page of the mobile app
      CLIENT_ID = 'tide-api-gem'.freeze
      # Complete HTTP response
      RESPONSE = "HTTP/1.1 200 OK\r\n" \
                 "Content-Type: text/plain\r\n" \
                 "Content-Length: 31\r\n" \
                 "Connection: close\r\n" \
                 "\r\n" \
                 "You can now close this window.\n".freeze

      def initialize
        @server = TCPServer.new('localhost', 0)
        @port = server.addr[1]
      end

      # Runs a tiny HTTP server to receive OAuth2 callbacks.
      #
      # @return [String] The authentication grant code from Tide.
      #
      def run
        puts 'Waiting for the authorization code...'
        request_auth_nonce

        socket = server.accept
        auth_nonce = extract_auth_nonce(socket.gets)

        puts 'Authorization code received.'

        socket.print RESPONSE
        socket.close

        auth_nonce
      end

      private

      # @api private
      def request_auth_nonce
        system("open '#{auth_page_url}'")
      end

      # @api private
      def redirect_url
        "http://localhost:#{port}&client_id=#{CLIENT_ID}"
      end

      # @api private
      def auth_page_url
        "https://api.tide.co/tide-backend/oauth/index.html?redirect_url=#{redirect_url}"
      end

      # @api private
      def extract_auth_nonce(http_response_line)
        http_response_line.split('=').last.split.first
      end

      # @api private
      attr_reader :server, :port
    end
  end
end
