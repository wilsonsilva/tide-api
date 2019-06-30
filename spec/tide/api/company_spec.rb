require 'tide/api/company'

RSpec.describe Tide::API::Company do
  let(:attributes) do
    {
      company_id: 21123,
      number: '10567332',
      name: 'Poetic Justice Ltd',
      trading_name: 'Poetic Justice',
      sic_code: 62020,
      vat_number: '102381982',
      registered: true,
      iso_created_on: '2017-05-15T12:00:04Z',
      iso_updated_on: '2019-05-24T11:01:30Z'
    }
  end

  let(:company) { described_class.new(attributes) }

  describe '#company_id' do
    it "exposes Tide's internal company ID" do
      expect(company.company_id).to eq(attributes.fetch(:company_id))
    end
  end

  describe '#number' do
    it 'exposes company number' do
      expect(company.number).to eq(attributes.fetch(:number))
    end
  end

  describe '#name' do
    it 'exposes company name' do
      expect(company.name).to eq(attributes.fetch(:name))
    end
  end

  describe '#trading_name' do
    it 'exposes company trading name' do
      expect(company.trading_name).to eq(attributes.fetch(:trading_name))
    end
  end

  describe '#sic_code' do
    it 'exposes company nature of business SIC code' do
      expect(company.sic_code).to eq(attributes.fetch(:sic_code))
    end
  end

  describe '#vat_number' do
    it 'exposes company registered VAT code' do
      expect(company.vat_number).to eq(attributes.fetch(:vat_number))
    end
  end

  describe '#registered' do
    it 'exposes whether the company is VAT registered or not' do
      expect(company.registered).to eq(attributes.fetch(:registered))
    end
  end
end
