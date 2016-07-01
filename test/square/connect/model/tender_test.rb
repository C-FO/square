require 'test_helper'

describe Square::Connect::Tender do
  let(:tender) do
    Square::Connect::Tender.new(
      id: "7OlOmDbt3PMV4CT1q0NnKQB",
      type: "CREDIT_CARD",
      card_brand: "VISA",
      name: "VISA-1234",
      pan_suffix: "1234",
      entry_method: "SWIPED",
      payment_note: "A note about the tender",
      total_money: {},
      tendered_money: {},
      change_back_money: {},
      refunded_money: {}
    )
  end

  describe '.superclass' do
    it 'is Square::Model::Base' do
      Square::Connect::Tender.superclass.must_equal Square::Model::Base
    end
  end

  describe '.from_response' do
    it 'returns an instance of Square::Connect::Tender' do
      Square::Connect::Tender.from_response(body: {id: 1}).must_be_instance_of Square::Connect::Tender
    end
  end

  describe '#type' do
    it 'returns string value' do
      tender.type.must_equal "CREDIT_CARD"
    end
  end

  describe '#type' do
    it 'returns string value' do
      tender.type.must_equal "CREDIT_CARD"
    end
  end

  describe '#card_brand' do
    it 'returns string value' do
      tender.card_brand.must_equal "VISA"
    end
  end

  describe '#name' do
    it 'returns string value' do
      tender.name.must_equal "VISA-1234"
    end
  end

  describe '#pan_suffix' do
    it 'returns string value' do
      tender.pan_suffix.must_equal "1234"
    end
  end

  describe '#entry_method' do
    it 'returns string value' do
      tender.entry_method.must_equal "SWIPED"
    end
  end

  describe "#id" do
    it 'returns string value' do
      tender.id.must_equal "7OlOmDbt3PMV4CT1q0NnKQB"
    end
  end

  describe '#total_money' do
    it 'returns an instance of Square::Connect::Money' do
      tender.total_money.must_be_instance_of Square::Connect::Money
    end
  end

  describe '#tendered_money' do
    it 'returns an instance of Square::Connect::Money' do
      tender.tendered_money.must_be_instance_of Square::Connect::Money
    end
  end

  describe '#change_back_money' do
    it 'returns an instance of Square::Connect::Money' do
      tender.change_back_money.must_be_instance_of Square::Connect::Money
    end
  end

  describe '#refunded_money' do
    it 'returns an instance of Square::Connect::Money' do
      tender.refunded_money.must_be_instance_of Square::Connect::Money
    end
  end

end
