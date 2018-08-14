require 'spec_helper'

describe Square::Connect::PaymentDiscount do
  let(:payment_discount) do
    described_class.new(
      name: name,
      applied_money: {}
    )
  end
  let(:name) { 'B5CX9A21Z' }

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

  describe '#name' do
    it { expect(payment_discount.name).to eq(name) }
  end

  describe '#applied_money' do
    it { expect(payment_discount.applied_money).to be_instance_of(Square::Connect::Money) }
  end
end
