module Tide
  module API
    # A business company owned by the account holder
    class Company < Dry::Struct::Value
      # Tide's unique ID of the company.
      #
      # @return [Integer]
      #
      attribute :company_id, Types::Strict::Integer

      # Registration number in Companies House.
      #
      # @return [String]
      #
      attribute :number, Types::Strict::String

      # Legal name of the company.
      #
      # @return [Integer]
      #
      attribute :name, Types::Strict::String

      # Trading name of the company.
      #
      # @return [Integer]
      #
      attribute :trading_name, Types::Strict::String

      # SIC code.
      #
      # @return [Integer|nil]
      #
      attribute :sic_code, Types::Strict::Integer.optional

      # VAT number.
      #
      # @return [String|nil]
      #
      attribute :vat_number, Types::Strict::String.optional

      # Wether the company is registered or not? TODO
      #
      # @return [Boolean]
      #
      attribute :registered, Types::Strict::Bool

      # Date when the company was created in Tide.
      #
      # @return [DateTime]
      #
      attribute :iso_created_on, Types::Params::DateTime

      # Date when the company was was updated in Tide.
      #
      # @return [DateTime]
      #
      attribute :iso_updated_on, Types::Params::DateTime
    end
  end
end
