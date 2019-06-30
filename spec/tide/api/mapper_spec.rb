RSpec.describe Tide::API::Mapper do
  let(:mapper) { described_class.new }

  describe '#map' do
    let(:error_hashes) do
      [
        {
          code: 300,
          message: 'An unknown error occurred while processing your request',
          details: 'Additional details'
        }
      ]
    end

    it 'transforms an array of hashes into objects of a given class' do
      errors = mapper.map(error_hashes, Tide::API::Error)

      expect(errors).to contain_exactly(
        Tide::API::Error.new(
          code: 300,
          message: 'An unknown error occurred while processing your request',
          details: 'Additional details'
        )
      )
    end
  end

  describe '#map_one' do
    let(:error_hash) do
      {
        code: 300,
        message: 'An unknown error occurred while processing your request',
        details: 'Additional details'
      }
    end

    it 'transforms a hash into an object of a given class' do
      error = mapper.map_one(error_hash, Tide::API::Error)

      expect(error).to eq(
        Tide::API::Error.new(
          code: 300,
          message: 'An unknown error occurred while processing your request',
          details: 'Additional details'
        )
      )
    end
  end
end
