require 'spec_helper'

describe Square::Connect::PaymentItemization do
  let(:name) { 'Donut' }
  let(:quantity) { SecureRandom.random_number(10000000) }
  let(:notes) { 'abc' }
  let(:item_variation_name) { name + '2' }
  let(:payment_itemization) do
    described_class.new(
      name: name,
      quantity: quantity,
      notes: notes,
      item_variation_name: item_variation_name,
      item_detail: {},
      total_money: {},
      single_quantity_money: {},
      gross_sales_money: {},
      discount_money: {},
      taxes: [{}],
      discounts: [{}]
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
      expect(payment_itemization).to have_attributes(
        name: name,
        quantity: quantity,
        notes: notes,
        item_variation_name: item_variation_name,
      )
      expect(payment_itemization.item_detail).to be_instance_of(Square::Connect::PaymentItemDetail)
      expect(payment_itemization.total_money).to be_instance_of(Square::Connect::Money)
      expect(payment_itemization.single_quantity_money).to be_instance_of(Square::Connect::Money)
      expect(payment_itemization.gross_sales_money).to be_instance_of(Square::Connect::Money)
      expect(payment_itemization.discount_money).to be_instance_of(Square::Connect::Money)
      expect(payment_itemization.taxes).to all(be_instance_of(Square::Connect::PaymentTax))
      expect(payment_itemization.discounts).to all(be_instance_of(Square::Connect::PaymentDiscount))
    end
  end
end
