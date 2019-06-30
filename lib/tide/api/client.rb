require 'tide/api/http_client'
require 'tide/api/mapper'
require 'tide/api/account'
require 'tide/api/transaction'
require 'tide/api/company'
require 'tide/api/error'
require 'tide/api/tokens'

module Tide
  module API
    # Main interface to Tide API
    class Client
      # Base path to Tide API version 1
      BASE_PATH = 'https://api.tide.co/tide-backend/rest/api/v1'.freeze

      # Instantiates an API client
      #
      # @param [Mapper] mapper Converts JSON responses into concrete instances of Tide API concepts
      # @param [HTTPClient] http_client Performs HTTP requests
      #
      def initialize(mapper: Mapper.new, http_client: HTTPClient.new)
        @mapper = mapper
        @http_client = http_client
      end

      # Exchanges an auth nonce for OAuth2 access and refresh tokens.
      #
      # @param [String] auth_grant_code An authentication nonce provided by the OAuth2 redirect callback.
      #
      def fetch_tokens(auth_grant_code)
        response = http_client.get("#{BASE_PATH}/oauth2/tokens?code=#{auth_grant_code}")

        return build_error_from(response) if response.error?

        build_tokens_from(response).tap do |tokens|
          http_client.refresh_token = tokens.refresh_token
          http_client.access_token  = tokens.access_token
        end
      end

      # Retrieves all companies of the authenticated user
      #
      # @return [Error|Array<Company>] A list of companies
      #
      def fetch_companies
        response = http_client.get("#{BASE_PATH}/external/companies")
        response.error? && build_error_from(response) || build_companies_from(response)
      end

      # Retrieves all accounts of a given company
      #
      # @param [Integer] company_id Tide's internal ID of the company
      #
      # @return [Error|Array<Transaction>]
      #
      def fetch_accounts(company_id)
        response = http_client.get("#{BASE_PATH}/external/companies/#{company_id}/accounts")
        response.error? && build_error_from(response) || build_accounts_from(response)
      end

      # Retrieves all transactions of a given account
      #
      # @param [Integer] account_id Tide's internal ID of the account
      #
      # @return [Error|Array<Transaction>]
      #
      def fetch_transactions(account_id)
        response = http_client.get("#{BASE_PATH}/external/accounts/#{account_id}/transactions")
        response.error? && build_error_from(response) || build_transactions_from(response)
      end

      private

      # @api private
      attr_reader :mapper, :http_client

      # @api private
      def build_tokens_from(response)
        mapper.map_one(response.payload, Tokens)
      end

      # @api private
      def build_companies_from(response)
        mapper.map(response.payload, Company)
      end

      # @api private
      def build_transactions_from(response)
        mapper.map(response.payload, Transaction)
      end

      # @api private
      def build_accounts_from(response)
        mapper.map(response.payload, Account)
      end

      # @api private
      def build_error_from(response)
        mapper.map_one(response.payload, Error)
      end
    end
  end
end
