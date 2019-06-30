require 'tide/api/error'

RSpec.describe Tide::API::Error do
  let(:attributes) do
    {
      code: 300,
      message: 'An unknown error occurred while processing your request',
      details: 'Additional details'
    }
  end

  let(:error) { described_class.new(attributes) }

  describe '#code' do
    it 'exposes the error code' do
      expect(error.code).to eq(attributes.fetch(:code))
    end
  end

  describe '#message' do
    it 'exposes the error message' do
      expect(error.message).to eq(attributes.fetch(:message))
    end
  end

  describe '#details' do
    it 'exposes the error details' do
      expect(error.details).to eq(attributes.fetch(:details))
    end
  end
end
