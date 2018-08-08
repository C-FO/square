require 'spec_helper'

describe Square::Connect::Merchant do
  let(:json) { fixture('merchant.json') }
  let(:class_attrs) { JSON.load(json).symbolize_keys }
  let(:instance) { described_class.new(class_attrs) }

  describe '.superclass' do
    subject { described_class.superclass }

    it { is_expected.to eq(Square::Model::Identity) }
  end
  describe '.from_response' do
    subject { described_class.from_response(body: body) }

    context 'when body set' do
      let(:body) { { id: 1 } }

      it { is_expected.to be_instance_of(described_class) }
    end
  end
  describe '#name' do
    it { expect(instance.name).to eq('Crazy Dave\'s Taco Stand') }
  end
  describe '#email' do
    it { expect(instance.email).to eq('dave@example.com') }
  end

  describe '#country_code' do
    it { expect(instance.country_code).to eq('CA') }
  end

  describe '#language_code' do
    it { expect(instance.language_code).to eq('en-CA') }
  end
end
