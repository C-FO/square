require 'spec_helper'

describe Square::Connect::SettlementEntry do
  let(:payment_id) { 'Jq74mCczmFXk1tC10GB' }
  let(:settlement_entry) do
    described_class.new(
      payment_id: payment_id,
      type: 'PAYMENT',
      amount_money: {},
      fee_money: {}
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
      expect(settlement_entry).to have_attributes(
        payment_id: payment_id,
        type: 'PAYMENT'
      )
      expect(settlement_entry.amount_money).to be_instance_of(Square::Connect::Money)
      expect(settlement_entry.fee_money).to be_instance_of(Square::Connect::Money)
    end
  end
end
