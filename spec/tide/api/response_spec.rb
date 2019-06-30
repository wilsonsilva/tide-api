RSpec.describe Tide::API::Response do
  let(:payload) do
    {
      error: {
        code: 300,
        message: 'An unknown error occurred while processing your request',
        details: 'Additional details'
      }
    }
  end
  let(:response) { described_class.new(payload, true) }

  describe '#payload' do
    it 'exposes the stored response body' do
      expect(response.payload).to eq(payload)
    end
  end

  describe '#error?' do
    it 'exposes whether there was an error in the response or not ' do
      expect(response.error?).to eq(true)
    end
  end
end
