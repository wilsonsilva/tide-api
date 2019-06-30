RSpec.describe Tide::API::Types do
  it 'contains type definitions from dry-types' do
    aggregate_failures do
      expect(described_class.const_defined?(:Strict)).to eq(true)
      expect(described_class.const_defined?(:Coercible)).to eq(true)
      expect(described_class.const_defined?(:Params)).to eq(true)
    end
  end
end
