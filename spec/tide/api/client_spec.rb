require 'tide/api/client'

RSpec.describe Tide::API::Client, vcr: true do
  let(:client) { described_class.new }

  describe '#fetch_tokens' do
    context 'when the auth grant code has not been used yet' do
      let(:auth_grant_code) { 'CBCAzT2L6A5oFZyE78R2TtYYtaJ60er0' }

      it 'returns authentication tokens' do
        tokens = client.fetch_tokens(auth_grant_code)

        aggregate_failures do
          expect(tokens.access_token).to eq('JNfZPNNzk5yKw8rv0MHkZcFNNRrlK82Q')
          expect(tokens.refresh_token).to eq('ORTWOfrQwpeD3AUNWTgYnL8mPY0FU6MV')
        end
      end
    end

    context 'when the auth grant code is missing' do
      it 'raises an exception' do
        expect { client.fetch_tokens('') }.to raise_error JSON::ParserError
      end
    end

    context 'when the auth grant code is invalid' do
      let(:auth_grant_code) { 'theRealDonaldTrump' }

      it 'returns an error' do
        error = client.fetch_tokens(auth_grant_code)

        aggregate_failures do
          expect(error.code).to eq(300)
          expect(error.message).to eq('An unknown error occurred while processing your request.')
        end
      end
    end

    context 'when the auth grant code has already been used' do
      let(:auth_grant_code) { 'CBCAzT2L6A5oFZyE78R2TtYYtaJ60er0' }

      it 'returns an error' do
        error = client.fetch_tokens(auth_grant_code)

        aggregate_failures do
          expect(error.code).to eq(300)
          expect(error.message).to eq('An unknown error occurred while processing your request.')
        end
      end
    end
  end

  describe '#fetch_companies' do
    context 'when the access token is valid' do
      let(:http_client) do
        Tide::API::HTTPClient.new.tap do |http_client|
          http_client.access_token = 'M5EmqWpeuiou83huuOPP4jNMEFJ8bRBD'
        end
      end

      let(:client) { described_class.new(http_client: http_client) }

      it "returns the user's companies" do
        companies = client.fetch_companies

        expect(companies).to all(be_an_instance_of(Tide::API::Company))
      end
    end

    context 'when the access token is missing' do
      let(:http_client) { Tide::API::HTTPClient.new }
      let(:client) { described_class.new(http_client: http_client) }

      it 'returns an error' do
        error = client.fetch_companies

        aggregate_failures do
          expect(error.code).to eq(3)
          expect(error.message).to eq('An unknown error occurred while processing your request.')
          expect(error.details).to eq(nil)
        end
      end
    end

    context 'when the access token is invalid' do
      let(:http_client) do
        Tide::API::HTTPClient.new.tap do |http_client|
          http_client.access_token = 'theRealDonaldTrump'
        end
      end

      let(:client) { described_class.new(http_client: http_client) }

      it 'returns an error' do
        error = client.fetch_companies

        aggregate_failures do
          expect(error.code).to eq(10)
          expect(error.message).to eq('We were unable to authenticate this request.')
          expect(error.details).to eq(nil)
        end
      end
    end
  end

  describe '#fetch_accounts' do
    context 'when the access token is valid' do
      let(:http_client) do
        Tide::API::HTTPClient.new.tap do |http_client|
          http_client.access_token = 'M5EmqWpeuiou83huuOPP4jNMEFJ8bRBD'
        end
      end

      let(:client) { described_class.new(http_client: http_client) }
      let(:company_id) { 17918 }

      it "returns the user's bank accounts" do
        accounts = client.fetch_accounts(company_id)

        expect(accounts).to all(be_an_instance_of(Tide::API::Account))
      end
    end

    context 'when the access token is missing' do
      let(:http_client) { Tide::API::HTTPClient.new }
      let(:client) { described_class.new(http_client: http_client) }
      let(:company_id) { 17918 }

      it 'returns an error' do
        error = client.fetch_accounts(company_id)

        aggregate_failures do
          expect(error.code).to eq(3)
          expect(error.message).to eq('An unknown error occurred while processing your request.')
          expect(error.details).to eq(nil)
        end
      end
    end

    context 'when the access token is invalid' do
      let(:http_client) do
        Tide::API::HTTPClient.new.tap do |http_client|
          http_client.access_token = 'theRealDonaldTrump'
        end
      end

      let(:client) { described_class.new(http_client: http_client) }
      let(:company_id) { 17918 }

      it 'returns an error' do
        error = client.fetch_accounts(company_id)

        aggregate_failures do
          expect(error.code).to eq(10)
          expect(error.message).to eq('We were unable to authenticate this request.')
          expect(error.details).to eq(nil)
        end
      end
    end

    context 'when the company id is missing' do
      let(:http_client) do
        Tide::API::HTTPClient.new.tap do |http_client|
          http_client.access_token = 'theRealDonaldTrump'
        end
      end

      let(:client) { described_class.new(http_client: http_client) }

      it 'returns an error' do
        error = client.fetch_accounts('')

        aggregate_failures do
          expect(error.code).to eq(4)
          expect(error.message).to eq('An unknown error occurred while processing your request.')
          expect(error.details).to eq(nil)
        end
      end
    end

    context 'when the company id is invalid' do
      let(:http_client) do
        Tide::API::HTTPClient.new.tap do |http_client|
          http_client.access_token = 'theRealDonaldTrump'
        end
      end

      let(:client) { described_class.new(http_client: http_client) }

      it 'returns an error' do
        error = client.fetch_accounts('theRealDonaldTrump')

        aggregate_failures do
          expect(error.code).to eq(10)
          expect(error.message).to eq('We were unable to authenticate this request.')
          expect(error.details).to eq(nil)
        end
      end
    end
  end

  describe '#fetch_transactions' do
    context 'when the access token is valid' do
      let(:http_client) do
        Tide::API::HTTPClient.new.tap do |http_client|
          http_client.access_token = 'M5EmqWpeuiou83huuOPP4jNMEFJ8bRBD'
        end
      end

      let(:client) { described_class.new(http_client: http_client) }
      let(:account_id) { 10172 }

      it "returns the user's bank transactions" do
        accounts = client.fetch_transactions(account_id)

        expect(accounts).to all(be_an_instance_of(Tide::API::Transaction))
      end
    end

    context 'when the access token is missing' do
      let(:http_client) { Tide::API::HTTPClient.new }
      let(:client) { described_class.new(http_client: http_client) }
      let(:account_id) { 10172 }

      it 'returns an error' do
        error = client.fetch_transactions(account_id)

        aggregate_failures do
          expect(error.code).to eq(3)
          expect(error.message).to eq('An unknown error occurred while processing your request.')
          expect(error.details).to eq(nil)
        end
      end
    end

    context 'when the access token is invalid' do
      let(:http_client) do
        Tide::API::HTTPClient.new.tap do |http_client|
          http_client.access_token = 'theRealDonaldTrump'
        end
      end

      let(:client) { described_class.new(http_client: http_client) }
      let(:account_id) { 10172 }

      it 'returns an error' do
        error = client.fetch_transactions(account_id)

        aggregate_failures do
          expect(error.code).to eq(10)
          expect(error.message).to eq('We were unable to authenticate this request.')
          expect(error.details).to eq(nil)
        end
      end
    end

    context 'when the account id is missing' do
      let(:http_client) do
        Tide::API::HTTPClient.new.tap do |http_client|
          http_client.access_token = 'theRealDonaldTrump'
        end
      end

      let(:client) { described_class.new(http_client: http_client) }

      it 'returns an error' do
        error = client.fetch_transactions('')

        aggregate_failures do
          expect(error.code).to eq(4)
          expect(error.message).to eq('An unknown error occurred while processing your request.')
          expect(error.details).to eq(nil)
        end
      end
    end

    context 'when the account id is invalid' do
      let(:http_client) do
        Tide::API::HTTPClient.new.tap do |http_client|
          http_client.access_token = 'theRealDonaldTrump'
        end
      end

      let(:client) { described_class.new(http_client: http_client) }

      it 'returns an error' do
        error = client.fetch_transactions('theRealDonaldTrump')

        aggregate_failures do
          expect(error.code).to eq(10)
          expect(error.message).to eq('We were unable to authenticate this request.')
          expect(error.details).to eq(nil)
        end
      end
    end
  end
end
