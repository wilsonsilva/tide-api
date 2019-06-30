require 'tide/api/tokens'

RSpec.describe Tide::API::Tokens do
  let(:attributes) do
    {
      access_token: 'ORTWOfrQwpeD3AUNWTgYnL8mPY0FU6MV',
      refresh_token: 'JNfZPNNzk5yKw8rv0MHkZcFNNRrlK82Q'
    }
  end

  let(:tokens) { described_class.new(attributes) }

  describe '#access_token' do
    it 'exposes an access token' do
      expect(tokens.access_token).to eq(attributes.fetch(:access_token))
    end
  end

  describe '#refresh_token' do
    it 'exposes a refresh token' do
      expect(tokens.refresh_token).to eq(attributes.fetch(:refresh_token))
    end
  end
end
