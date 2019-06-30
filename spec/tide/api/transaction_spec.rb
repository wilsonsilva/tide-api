RSpec.describe Tide::API::Transaction do
  let(:transaction) do
    described_class.new(
      transaction_id: 446308,
      account_id: 23271,
      amount: -181.7,
      type: 'RED',
      txn_ref: 'T17092512072329291',
      iso_transaction_date_time: '2017-09-25T11:07:23Z',
      iso_applied_date_time: '2017-09-26T10:36:51Z',
      iso_cleared_date_time: '2017-09-26T10:36:51Z',
      masked_pan: '**** **** **** 4242',
      status: 'cleared',
      description: 'LUL TICKET MACHINE - COCKFOSTERS ROAD, COCKFOSTERS',
      iso_created_on: '2017-09-25T11:43:16Z',
      iso_updated_on: '2017-09-28T04:03:02Z',
      category_id: 110679,
      category_name: 'Travel',
      category_type: 'EXPENDITURE'
    )
  end

  describe '#transaction_id' do
    it "exposes Tide's internal transaction id" do
      expect(transaction.transaction_id).to eq(446308)
    end
  end

  describe '#account_id' do
    it "exposes Tide's internal account id" do
      expect(transaction.account_id).to eq(23271)
    end
  end

  describe '#amount' do
    it 'exposes the transaction amount' do
      expect(transaction.amount).to eq(BigDecimal('-181.7'))
    end
  end

  describe '#type' do
    it 'exposes the transaction type' do
      expect(transaction.type).to eq('RED')
    end
  end

  describe '#txn_ref' do
    it 'exposes the transaction reference' do
      expect(transaction.txn_ref).to eq('T17092512072329291')
    end
  end

  describe '#iso_transaction_date_time' do
    it 'exposes the transaction time' do
      expect(transaction.iso_transaction_date_time).to eq(DateTime.parse('2017-09-25T11:07:23Z'))
    end
  end

  describe '#iso_applied_date_time' do
    it 'exposes the transaction applied time' do
      expect(transaction.iso_applied_date_time).to eq(DateTime.parse('2017-09-26T10:36:51Z'))
    end
  end

  describe '#masked_pan' do
    it 'exposes the masked card number used for the transaction' do
      expect(transaction.masked_pan).to eq('**** **** **** 4242')
    end
  end

  describe '#status' do
    it 'exposes the transaction status' do
      expect(transaction.status).to eq('cleared')
    end
  end

  describe '#description' do
    it 'exposes the transaction description' do
      expect(transaction.description).to eq('LUL TICKET MACHINE - COCKFOSTERS ROAD, COCKFOSTERS')
    end
  end

  describe '#iso_created_on' do
    it 'exposes the transaction creation time' do
      expect(transaction.iso_created_on).to eq(DateTime.parse('2017-09-25T11:43:16Z'))
    end
  end

  describe '#iso_updated_on' do
    it 'exposes the transaction last update time' do
      expect(transaction.iso_updated_on).to eq(DateTime.parse('2017-09-28T04:03:02Z'))
    end
  end

  describe '#category_id' do
    it 'exposes the transaction category ID' do
      expect(transaction.category_id).to eq(110679)
    end
  end

  describe '#category_name' do
    it 'exposes the transaction category name' do
      expect(transaction.category_name).to eq('Travel')
    end
  end

  describe '#category_type' do
    it 'exposes the transaction category type' do
      expect(transaction.category_type).to eq('EXPENDITURE')
    end
  end
end
