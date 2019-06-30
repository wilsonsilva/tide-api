require 'tide/api/account'

RSpec.describe Tide::API::Account do
  let(:attributes) do
    {
      account_id: 21123,
      company_id: 28959,
      account_number: '13097032',
      name: 'Tide Current Account',
      balance: BigDecimal('63615.49'),
      available_balance: BigDecimal('63615.49'),
      currency_code: 'GBP',
      sort_code: '347871',
      iso_created_on: '2017-05-15T12:00:04Z',
      iso_updated_on: '2019-05-24T11:01:30Z'
    }
  end

  let(:account) { described_class.new(attributes) }

  describe '#account_id' do
    it "exposes Tide's internal account ID" do
      expect(account.account_id).to eq(attributes.fetch(:account_id))
    end
  end

  describe '#company_id' do
    it "exposes Tide's internal company ID" do
      expect(account.company_id).to eq(attributes.fetch(:company_id))
    end
  end

  describe '#account_number' do
    it 'exposes the bank account number' do
      expect(account.account_number).to eq(attributes.fetch(:account_number))
    end
  end

  describe '#sort_code' do
    it 'exposes the bank account sort code' do
      expect(account.sort_code).to eq(attributes.fetch(:sort_code))
    end
  end

  describe '#currency_code' do
    it 'exposes the bank account currency ISO code' do
      expect(account.currency_code).to eq(attributes.fetch(:currency_code))
    end
  end

  describe 'iso_created_on' do
    it 'exposes the bank account creation date' do
      expected_date = DateTime.parse(attributes.fetch(:iso_created_on))
      expect(account.iso_created_on).to eq(expected_date)
    end
  end

  describe 'iso_updated_on' do
    it 'exposes the bank account last update date' do
      expected_date = DateTime.parse(attributes.fetch(:iso_updated_on))
      expect(account.iso_updated_on).to eq(expected_date)
    end
  end
end
