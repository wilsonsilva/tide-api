module Tide
  module API
    # An error resulting from an API call
    class Error < Dry::Struct::Value
      # A code that uniquely identifies the error
      #
      # @return [Integer]
      #
      attribute :code, Types::Strict::Integer

      # A human readable description of the code
      #
      # @return [String]
      #
      attribute :message, Types::Strict::String

      # A long description of the error. Unfortunately, it is null most of the time.
      #
      # @return [String|nil]
      #
      attribute :details, Types::Strict::String.optional
    end
  end
end
