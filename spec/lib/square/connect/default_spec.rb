require 'spec_helper'

describe Square::Connect::Default do
  describe '.options' do
    subject { described_class.options }
    it 'returns a hash with the same keys as Square::Connect::Configuration' do
      expect(subject.keys).to eq(Square::Connect::Configuration.keys)
    end
  end

  describe '.api_version' do
    subject { described_class.api_version }
    it 'returns ::API_VERSION' do
      expect(subject).to eq(Square::Connect::Default::API_VERSION)
    end
  end

  describe '.endpoint' do
    subject { described_class.endpoint }
    it 'returns ::ENDPOINT' do
      expect(subject).to eq(Square::Connect::Default::ENDPOINT)
    end
  end
end
