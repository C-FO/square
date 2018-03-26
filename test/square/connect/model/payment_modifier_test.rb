require 'test_helper'

describe Square::Connect::PaymentModifier do
  let(:payment_modifier) do
    Square::Connect::PaymentModifier.new(
      name: "B5CX9A21Z",
      applied_money: {}
    )
  end

  describe '.superclass' do
    it 'is Square::Model::Base' do
      Square::Connect::PaymentModifier.superclass.must_equal Square::Model::Base
    end
  end

  describe '.from_response' do
    it 'returns an instance of Square::Connect::PaymentModifier' do
      Square::Connect::PaymentModifier.from_response(body: {id: 1}).must_be_instance_of Square::Connect::PaymentModifier
    end
  end

  describe '#name' do
    it 'returns string value' do
      payment_modifier.name.must_equal "B5CX9A21Z"
    end
  end

  describe '#applied_money' do
    it 'returns an instance of Square::Connect::Money' do
      payment_modifier.applied_money.must_be_instance_of Square::Connect::Money
    end
  end

end
