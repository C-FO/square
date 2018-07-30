require 'spec_helper'

describe Square::Connect::Device do
  let(:json) { fixture('device.json') }
  let(:class_attrs) { JSON.load(json).symbolize_keys }
  let(:device) { described_class.new(class_attrs) }

  describe '.superclass' do
    subject { described_class.superclass }
    it 'returns Square::Model::Identity' do
      is_expected.to eq(Square::Model::Identity)
    end
  end

  describe '.from_response' do
    subject { described_class.from_response(body: body) }

    context 'when body set' do
      let(:body) { { id: 1 } }

      it { is_expected.to be_instance_of(described_class) }
    end
  end

  describe '#name' do
    it { expect(device.name).to eq('AV76FTX15L') }
  end
end
