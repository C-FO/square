require 'spec_helper'

describe Square::Connect::Tender do
  let(:id) { "7OlOmDbt3PMV4CT1q0NnKQB" }
  let(:type) { 'CREDIT_CARD' }
  let(:name) { 'VISA-1234' }
  let(:brand) { 'VISA' }
  let(:entry_method) { 'SWIPED' }
  let(:pan_suffix) { '1234' }
  let(:payment_note) { 'A note about the tender' }
  let(:tender) do
    described_class.new(
      id: id,
      type: type,
      card_brand: brand,
      name: name,
      pan_suffix: pan_suffix,
      entry_method: entry_method,
      payment_note: payment_note,
      total_money: {},
      tendered_money: {},
      change_back_money: {},
      refunded_money: {}
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
      expect(tender).to have_attributes(
        id: id,
        type: type,
        card_brand: brand,
        name: name,
        pan_suffix: pan_suffix,
        entry_method: entry_method,
      )
      expect(tender.total_money).to be_instance_of(Square::Connect::Money)
      expect(tender.tendered_money).to be_instance_of(Square::Connect::Money)
      expect(tender.change_back_money).to be_instance_of(Square::Connect::Money)
      expect(tender.refunded_money).to be_instance_of(Square::Connect::Money)
    end
  end
end
