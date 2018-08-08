require 'spec_helper'

describe Square::Connect::Money do
  let(:amount) { SecureRandom.random_number(1000000) }
  let(:money) do
    described_class.new(
      amount: amount,
      currency_code: 'USD'
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

  describe '#money' do
    it { expect(money.amount).to eq(amount) }
  end

  describe '#currency_code' do
    it { expect(money.currency_code).to eq('USD') }
  end
end
