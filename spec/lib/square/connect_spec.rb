require 'spec_helper'

describe Square::Connect do
  after { described_class.reset! }
  describe '.client' do
    subject { described_class.client }

    it { is_expected.to be_instance_of(Square::Connect::Client) }
  end
  describe '.respond_to?' do
    subject { described_class.respond_to?(method) }

    context 'method is merchant' do
      let(:method) { :merchant }
      it { is_expected.to be_truthy }
    end
  end

  describe '.method_missing' do
    it 'delegates to Square::Connect::Client' do
      expect(described_class.access_token).to be_nil
    end
    it 'raises NoMethodError when undefined method is called' do
      expect { described_class.undefined }.to raise_error(NoMethodError)
    end
  end
end
