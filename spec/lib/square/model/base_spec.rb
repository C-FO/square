require 'spec_helper'

describe Square::Model::Base do
  let(:base) { described_class.new(id: id, name: name) }
  let(:id) { SecureRandom.random_number(1000000) }
  let(:name) { SecureRandom.alphanumeric(10) }

  describe '.attr_reader' do
    before { described_class.attr_reader :name }

    it 'defines a getter method' do
      expect(base.name).to eq(name)
    end
    it 'defines an existence checker method' do
      expect(base.name?).to be_truthy
    end
  end

  describe '.from_response' do
    subject { described_class.from_response(arguments) }
    let(:arguments) { { body: { id: id } } }

    it { is_expected.to be_instance_of(described_class) }
  end
  describe '#initialize' do
    subject { described_class.new }

    it { is_expected.to be_instance_of(described_class) }
  end

  describe '#[]' do
    it 'with a symbol argument' do
      expect(base[:class]).to eq(described_class)
    end
    it 'with a string argument' do
      expect(base['class']).to eq(described_class)
    end
    it 'with a missing attribute' do
      expect(base['ubiregi']).to be_nil
    end
  end
  describe '#attrs' do
    subject { base.attrs }

    it ' returns a hash of attributes' do
      is_expected.to eq(id: id, name: name)
    end
  end

  describe '#update' do
    subject { base.update(id: new_id) }
    let(:new_id) { SecureRandom.random_number(1000000) }
    it 'updates an attributes' do
      expect { subject }.to change { base.attrs[:id] }.from(id).to(new_id)
    end
  end
end
