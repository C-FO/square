require 'spec_helper'

describe Square::Connect::Payment do
  let(:id) { 'Jq74mCczmFXk1tC10GB' }
  let(:merchant_id) { 'AV76FTXT15L' }
  let(:created_at) { '2013-01-02T00:00:00.000Z' }
  let(:creator_id) { 'B5CX9A21Z' }
  let(:description) { 'Lunch for one' }
  let(:device) { { id: '1' } }
  let(:payment) do
    described_class.new(
      id: id,
      merchant_id: merchant_id,
      created_at: created_at,
      creator_id: creator_id,
      description: description,
      device: device,
      inclusive_tax_money: {},
      additive_tax_money: {},
      tax_money: {},
      tip_money: {},
      discount_money: {},
      total_collected_money: {},
      processing_fee_money: {},
      net_total_money: {},
      refunded_money: {},
      inclusive_tax: [{}],
      additive_tax: [{}],
      tender: [{}],
      refunds: [{}],
      itemizations: [{}]
    )
  end

  describe '.superclass' do
    subject { described_class.superclass }
    it { is_expected.to eq(Square::Model::Identity) }
  end

  describe '.from_response' do
    subject { described_class.from_response(arguments) }
    let(:id) { SecureRandom.random_number(1000000) }
    let(:arguments) { { body: { id: id } } }
    it { is_expected.to be_instance_of(described_class) }
  end

  describe 'correctly attributes' do
    it do
      expect(payment).to have_attributes(
        id: id,
        merchant_id: merchant_id,
        creator_id: creator_id,
        description: description,
      )
      expect(payment.created_at).to eq(Time.utc(2013, 1, 2))
      expect(payment.device).to be_instance_of(Square::Connect::Device)
      expect(payment.inclusive_tax_money).to be_instance_of(Square::Connect::Money)
      expect(payment.additive_tax_money).to be_instance_of(Square::Connect::Money)
      expect(payment.tax_money).to be_instance_of(Square::Connect::Money)
      expect(payment.tip_money).to be_instance_of(Square::Connect::Money)
      expect(payment.discount_money).to be_instance_of(Square::Connect::Money)
      expect(payment.total_collected_money).to be_instance_of(Square::Connect::Money)
      expect(payment.processing_fee_money).to be_instance_of(Square::Connect::Money)
      expect(payment.net_total_money).to be_instance_of(Square::Connect::Money)
      expect(payment.refunded_money).to be_instance_of(Square::Connect::Money)
      expect(payment.inclusive_tax).to all(be_instance_of(Square::Connect::PaymentTax))
      expect(payment.additive_tax).to all(be_instance_of(Square::Connect::PaymentTax))
      expect(payment.tender).to all(be_instance_of(Square::Connect::Tender))
      expect(payment.refunds).to all(be_instance_of(Square::Connect::Refund))
      expect(payment.itemizations).to all(be_instance_of(Square::Connect::PaymentItemization))
    end
  end
end
