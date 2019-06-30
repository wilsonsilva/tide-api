module Tide
  module API
    # Bank account transaction
    class Transaction < Dry::Struct::Value
      # Categories of the transaction
      CategoryType = Types::Strict::String.enum('EXPENDITURE', 'INCOME')

      # Statuses of the transaction
      Status = Types::Strict::String.enum('cleared', 'pending')

      # Payment type codes
      Type = Types::Strict::String.enum(
        'PYI',     # Faster Payment In
        'PYI_REV', # Faster Payment In Reversal
        'PYO',	   # Faster Payment Out
        'TRD',	   # Inter-Account Transfer Out
        'TRC',	   # Inter-Account Transfer In
        'RED',	   # Card Payment Out
        'RED_REV', # Card Payment Reversal
        'WTH',     # Cash Withdrawal
        'WTH_REV', # Cash Withdrawal Reversal
        'REF',     # Refund
        'REF_REV', # Refund Reversal
        'FEE',	   # Fee
        'TOP',	   # Tide Credit
        'TOP_REV'  # Tide Credit Reversal
      )

      # Tide's unique transaction ID.
      #
      # @return [Integer]
      #
      attribute :transaction_id, Types::Strict::Integer

      # ID of the parent account.
      #
      # @return [Integer]
      #
      attribute :account_id, Types::Strict::Integer

      # Transaction amount. Can be positive or negative.
      #
      # @return [BigDecimal]
      #
      attribute :amount, Types::Params::Decimal

      # Transaction Type code.
      #
      # @see +Type+.
      # @return [String]
      #
      attribute :type, Type

      # Unique reference of the transaction.
      #
      # @return [String]
      #
      attribute :txn_ref, Types::Strict::String

      # Time of the transaction.
      #
      # @return [DateTime]
      #
      attribute :iso_transaction_date_time, Types::Params::DateTime

      # Time when the transaction was applied
      #
      # @return [DateTime]
      #
      attribute :iso_applied_date_time, Types::Params::DateTime

      # Time when the transaction was cleared.
      #
      # @return [DateTime]
      #
      attribute :iso_cleared_date_time, Types::Params::DateTime

      # Masked debit/credit card number.
      #
      # @return [String]
      #
      attribute :masked_pan, Types::Strict::String.optional

      # TODO
      #
      # @return [String]
      #
      attribute :status, Status

      # TODO
      #
      # @return [String]
      #
      attribute :description, Types::Strict::String

      # TODO
      #
      # @return [DateTime]
      #
      attribute :iso_created_on, Types::Params::DateTime

      # TODO
      #
      # @return [DateTime]
      #
      attribute :iso_updated_on, Types::Params::DateTime

      # TODO
      #
      # @return [Integer]
      #
      attribute :category_id, Types::Strict::Integer

      # TODO
      #
      # @return [String|String]
      #
      attribute :category_name, Types::Strict::String.optional

      # TODO
      #
      # @return [String|nil]
      #
      attribute :category_type, CategoryType.optional
    end
  end
end
