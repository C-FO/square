require 'spec_helper'

describe Square::Connect::Refund do
  let(:id) { 'R:34GEWHCJGPR40' }
  let(:payment_id) { 'JGHJ0343' }
  let(:merchant_id) { 'AV76FTXT15L' }
  let(:type) { 'FULL' }
  let(:created_at) { '2013-01-02T00:00:00.000Z' }
  let(:processed_at) { '2013-02-02T00:00:00.000Z' }
  let(:refund) do
    described_class.new(
      id: id,
      payment_id: payment_id,
      merchant_id: merchant_id,
      type: type,
      created_at: created_at,
      processed_at: processed_at,
      refunded_money: {},
      refunded_additive_tax_money: {},
      refunded_inclusive_tax_money: {},
      refunded_tax_money: {},
      refunded_tip_money: {},
      refunded_discount_money: {},
      refunded_processing_fee_money: {},
      refunded_inclusive_tax: [{}],
      refunded_additive_tax: [{}],
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
      expect(refund).to have_attributes(
        type: type,
        payment_id: payment_id,
        merchant_id: merchant_id,
        created_at: Time.utc(2013, 1, 2),
        processed_at: Time.utc(2013, 2, 2),
      )
      expect(refund.refunded_money).to be_instance_of(Square::Connect::Money)
      expect(refund.refunded_additive_tax_money).to be_instance_of(Square::Connect::Money)
      expect(refund.refunded_inclusive_tax_money).to be_instance_of(Square::Connect::Money)
      expect(refund.refunded_tax_money).to be_instance_of(Square::Connect::Money)
      expect(refund.refunded_tip_money).to be_instance_of(Square::Connect::Money)
      expect(refund.refunded_discount_money).to be_instance_of(Square::Connect::Money)
      expect(refund.refunded_processing_fee_money).to be_instance_of(Square::Connect::Money)
      expect(refund.refunded_inclusive_tax).to all(be_instance_of(Square::Connect::PaymentTax))
      expect(refund.refunded_additive_tax).to all(be_instance_of(Square::Connect::PaymentTax))
    end
  end
end
