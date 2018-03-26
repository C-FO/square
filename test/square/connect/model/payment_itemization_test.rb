require 'test_helper'

describe Square::Connect::PaymentItemization do
  let(:payment_itemization) do
    Square::Connect::PaymentItemization.new(
      name: "Donut",
      quantity: 12,
      notes: "abc",
      item_variation_name: "Donut2",
      item_detail: {},
      total_money: {},
      single_quantity_money: {},
      gross_sales_money: {},
      discount_money: {},
      taxes: [{}],
      discounts: [{}],
      modifiers: [{}]
    )
  end

  describe '.superclass' do
    it 'is Square::Model::Base' do
      Square::Connect::PaymentItemization.superclass.must_equal Square::Model::Base
    end
  end

  describe '.from_response' do
    it 'returns an instance of Square::Connect::PaymentItemization' do
      Square::Connect::PaymentItemization.from_response(body: {id: 1}).must_be_instance_of Square::Connect::PaymentItemization
    end
  end

  describe '#name' do
    it 'returns string value' do
      payment_itemization.name.must_equal "Donut"
    end
  end

  describe '#quantity' do
    it 'returns integer value' do
      payment_itemization.quantity.must_equal 12
    end
  end

  describe '#notes' do
    it 'returns string value' do
      payment_itemization.notes.must_equal "abc"
    end
  end

  describe '#item_variation_name' do
    it 'returns string value' do
      payment_itemization.item_variation_name.must_equal "Donut2"
    end
  end

  describe '#item_detail' do
    it 'returns an instance of Square::Connect::PaymentItemDetail' do
      payment_itemization.item_detail.must_be_instance_of Square::Connect::PaymentItemDetail
    end
  end

  describe '#total_money' do
    it 'returns an instance of Square::Connect::Money' do
      payment_itemization.total_money.must_be_instance_of Square::Connect::Money
    end
  end

  describe '#single_quantity_money' do
    it 'returns an instance of Square::Connect::Money' do
      payment_itemization.single_quantity_money.must_be_instance_of Square::Connect::Money
    end
  end

  describe '#gross_sales_money' do
    it 'returns an instance of Square::Connect::Money' do
      payment_itemization.gross_sales_money.must_be_instance_of Square::Connect::Money
    end
  end

  describe '#discount_money' do
    it 'returns an instance of Square::Connect::Money' do
      payment_itemization.discount_money.must_be_instance_of Square::Connect::Money
    end
  end

  describe '#taxes' do
    it 'returns an array of instances of Square::Connect::PaymentTax' do
      taxes = payment_itemization.taxes
      taxes.count.must_equal taxes.count {|t| t.is_a? Square::Connect::PaymentTax}
    end
  end

  describe '#discounts' do
    it 'returns an array of instances of Square::Connect::PaymentDiscount' do
      discounts = payment_itemization.discounts
      discounts.count.must_equal discounts.count {|t| t.is_a? Square::Connect::PaymentDiscount}
    end
  end

  describe '#modifiers' do
    it 'returns an array of instances of Square::Connect::PaymentModifier' do
      modifiers = payment_itemization.modifiers
      modifiers.count.must_equal modifiers.count {|t| t.is_a? Square::Connect::PaymentModifier}
    end
  end

end
