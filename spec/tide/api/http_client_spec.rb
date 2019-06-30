require 'tide/api/http_client'

RSpec.describe Tide::API::HTTPClient do
  let(:http_client) { described_class.new }

  describe '#get', vcr: true do
    let(:url) { 'https://api.tide.co/tide-backend/rest/api/v1/external/companies' }

    context 'when the access token is not set' do
      it 'issues unauthenticated GET requests' do
        response = http_client.get(url)
        expect(response).to be_error
      end
    end

    context 'when the access token is set and valid' do
      let(:valid_token) { 'DsUKgggaBGUyTgUTrMWsTzSwJsX0Itln' }

      before { http_client.access_token = valid_token }

      it 'issues authenticated GET requests' do
        response = http_client.get(url)
        expect(response).not_to be_error
      end
    end

    context 'when the access token is set and invalid' do
      let(:invalid_token) { 'realDonaldTrumpToken' }

      before { http_client.access_token = invalid_token }

      it 'issues unauthenticated GET requests' do
        response = http_client.get(url)
        expect(response).to be_error
      end
    end
  end

  describe '#access_token' do
    it 'exposes the access token used on the header of every request' do
      http_client.access_token = 'token'
      expect(http_client.access_token).to eq('token')
    end
  end

  describe '#access_token=' do
    it 'sets the access token to be used on the header of every request' do
      http_client.access_token = 'token'
      expect(http_client.access_token).to eq('token')
    end
  end
end
