require 'test_helper'

describe Square::Connect::Refund do
  let(:refund) do
    Square::Connect::Refund.new(
      id: "R:34GEWHCJGPR40",
      payment_id: "JGHJ0343",
      type: "FULL",
      created_at: "2013-01-02T00:00:00.000Z",
      processed_at: "2013-02-02T00:00:00.000Z",
      refunded_money: {},
      refunded_additive_tax_money: {},
      refunded_inclusive_tax_money: {},
      refunded_processing_fee_money: {},
    )
  end

  describe '.superclass' do
    it 'is Square::Model::Base' do
      Square::Connect::Refund.superclass.must_equal Square::Model::Base
    end
  end

  describe '.from_response' do
    it 'returns an instance of Square::Connect::Refund' do
      Square::Connect::Refund.from_response(body: {id: 1}).must_be_instance_of Square::Connect::Refund
    end
  end

  describe '#type' do
    it 'returns string value' do
      refund.type.must_equal "FULL"
    end
  end

  describe '#payment_id' do
    it 'returns string value' do
      refund.payment_id.must_equal "JGHJ0343"
    end
  end

  describe '#created_at' do
    it 'returns an instance of Time' do
      refund.created_at.must_equal Time.utc(2013, 1, 2)
    end
  end

  describe '#processed_at' do
    it 'returns an instance of Time' do
      refund.processed_at.must_equal Time.utc(2013, 2, 2)
    end
  end

  describe '#refunded_money' do
    it 'returns an instance of Square::Connect::Money' do
      refund.refunded_money.must_be_instance_of Square::Connect::Money
    end
  end

  describe '#refunded_additive_tax_money' do
    it 'returns an instance of Square::Connect::Money' do
      refund.refunded_additive_tax_money.must_be_instance_of Square::Connect::Money
    end
  end

  describe '#refunded_inclusive_tax_money' do
    it 'returns an instance of Square::Connect::Money' do
      refund.refunded_inclusive_tax_money.must_be_instance_of Square::Connect::Money
    end
  end

  describe '#refunded_processing_fee_money' do
    it 'returns an instance of Square::Connect::Money' do
      refund.refunded_processing_fee_money.must_be_instance_of Square::Connect::Money
    end
  end

end
