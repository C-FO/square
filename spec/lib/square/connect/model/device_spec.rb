require 'spec_helper'

describe Square::Connect::Device do
  let(:json) { fixture('device.json') }
  let(:class_attrs) { JSON.load(json).deep_symbolize_keys }

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
    subject { described_class.new(class_attrs) }

    it { expect(subject.name).to eq('AV76FTX15L') }
  end
end
