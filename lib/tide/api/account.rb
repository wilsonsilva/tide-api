module Tide
  module API
    # A bank account
    class Account < Dry::Struct::Value
      # Tide's unique account ID.
      #
      # @return [Integer]
      #
      attribute :account_id, Types::Strict::Integer

      # Tide's unique company ID.
      #
      # @return [Integer]
      #
      attribute :company_id, Types::Strict::Integer

      # The company's bank account number.
      #
      # @return [String]
      #
      attribute :account_number, Types::Strict::String

      # Account type.
      #
      # @return [String]
      #
      attribute :name, Types::Strict::String

      # Account balance.
      #
      # @return [BigDecimal]
      #
      attribute :balance, Types::Params::Decimal

      # Available account balance.
      #
      # @return [BigDecimal]
      #
      attribute :available_balance, Types::Params::Decimal

      # ISO 4217 currency code.
      #
      # @return [String]
      #
      attribute :currency_code, Types::Strict::String

      # Sort code of the bank account.
      #
      # @return [String]
      #
      attribute :sort_code, Types::Strict::String

      # Date of creation of the account.
      #
      # @return [DateTime]
      #
      attribute :iso_created_on, Types::Params::DateTime

      # Date when the account was last updated.
      #
      # @return [DateTime]
      #
      attribute :iso_updated_on, Types::Params::DateTime
    end
  end
end
