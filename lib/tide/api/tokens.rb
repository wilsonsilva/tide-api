module Tide
  module API
    # OAuth2 access and refresh tokens
    class Tokens < Dry::Struct::Value
      # OAuth2 Access Token
      #
      # @return [String]
      #
      attribute :access_token, Types::Strict::String

      # OAuth2 Refresh Token
      #
      # @return [String]
      #
      attribute :refresh_token, Types::Strict::String
    end
  end
end
