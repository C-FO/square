require 'spec_helper'

describe Square::Connect::Settlement do
  let(:id) { 'C:34GEWHCJGPR40' }
  let(:bank_account_id) { '543654645' }
  let(:initiated_at) { '2013-01-02T00:00:00.000Z' }
  let(:entries) { [{ id: 1 }] }
  let(:settlement) do
    described_class.new(
      id: id,
      status: 'SENT',
      bank_account_id: bank_account_id,
      initiated_at: initiated_at,
      total_money: {},
      entries: entries
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
      expect(settlement).to have_attributes(
        id: id,
        status: 'SENT',
        initiated_at: Time.utc(2013, 1, 2),
        bank_account_id: bank_account_id
      )
      expect(settlement.total_money).to be_instance_of(Square::Connect::Money)
      expect(settlement.entries).to all(be_instance_of(Square::Connect::SettlementEntry))
    end
  end
end