require 'spec_helper'

describe Square::Connect::PaymentItemDetail do
  let(:payment_item_detail) do
    described_class.new(
      category_name: category_name,
      sku: sku
    )
  end
  let(:category_name) { 'B5CX9A21Z' }
  let(:sku) { 'XUWE8RES90' }

  describe '.superclass' do
    subject { described_class.superclass }
    it { is_expected.to eq(Square::Model::Base) }
  end

  describe '.from_response' do
    subject { described_class.from_response(arguments) }
    let(:id) { SecureRandom.random_number(1000000) }
    let(:arguments) { { body: { id: id } } }
    it { is_expected.to be_instance_of(described_class) }
  end

  describe '#category_name' do
    it { expect(payment_item_detail.category_name).to eq(category_name) }
  end

  describe '#sku' do
    it { expect(payment_item_detail.sku).to eq(sku) }
  end
end

