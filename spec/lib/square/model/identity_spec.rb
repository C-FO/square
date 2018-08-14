require 'spec_helper'

describe Square::Model::Identity do
  describe '.superclass' do
    subject { described_class.superclass }
    it 'is Square::Model::Base' do
      is_expected.to eq(Square::Model::Base)
    end
  end

  describe '.initialize' do
    context 'with arguments' do
      subject { described_class.new(arguments) }
      let(:id) { SecureRandom.random_number(1000000) }
      let(:arguments) { { id: id } }
      it 'returns correctly object' do
        is_expected.to be_instance_of(described_class)
        is_expected.to have_attributes(id: id)
      end
    end
    context 'without arguments' do
      subject { described_class.new }
      it 'raises Argument with no id' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#==' do
    let(:identity1) { described_class.new(id: id1, name: 'identity1') }
    let(:identity2) { described_class.new(id: id2, name: 'identity2') }
    subject { identity1 == identity2 }
    context 'when ids are the same' do
      let(:id1) { 1 }
      let(:id2) { 1 }
      it { is_expected.to be_truthy }
    end
    context 'when ids are different' do
      let(:id1) { 1 }
      let(:id2) { 2 }
      it { is_expected.to be_falsey }
    end
    context 'when classes are different' do
      let(:identity2) { Square::Model::Base.new(id: id2) }
      let(:id1) { 1 }
      let(:id2) { 1 }
      it { is_expected.to be_falsey }
    end
  end

  describe '#id' do
    subject { described_class.new(id: id) }
    let(:id) { SecureRandom.random_number(1000000) }
    it 'returns id' do
      expect(subject.id).to eq(id)
    end
  end
end
