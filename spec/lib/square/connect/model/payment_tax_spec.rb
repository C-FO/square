require 'spec_helper'

describe Square::Connect::PaymentTax do
  let(:name) { 'B5CX9A21Z' }
  let(:rate) { '0.0025' }
  let(:inclusion_type) { 'ADDITIVE' }
  let(:applied_money) { {} }
  let(:payment_tax) do
    described_class.new(
      name: name,
      rate: rate,
      inclusion_type: inclusion_type,
      applied_money: applied_money
    )
  end

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

  describe 'correctly attributes' do
    it do
      expect(payment_tax).to have_attributes(
        name: name,
        rate: rate,
        inclusion_type: inclusion_type,
      )
      expect(payment_tax.applied_money).to be_instance_of(Square::Connect::Money)
    end
  end
end
