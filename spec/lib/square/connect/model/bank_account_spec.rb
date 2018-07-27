require 'spec_helper'

describe Square::Connect::BankAccount do
  let(:json) { fixture('bank_account.json') }
  let(:class_attrs) { JSON.load(json).symbolize_keys }
  let(:bank_account) { described_class.new(class_attrs) }
  describe '.superclass' do
    context 'returns Square::Model::Identity' do
      subject { bank_account.class.superclass }

      it { is_expected.to eq(Square::Model::Identity) }
    end
  end
  describe '.from_response' do
    context 'returns an instance of Square::Connect::BankAccount' do
      subject { described_class.from_response(body: body) }
      let(:id) { SecureRandom.random_number(100000) }
      let(:body) { { id: id } }
      it { is_expected.to be_instance_of(described_class) }
    end
  end
  describe 'Correctly Object' do
    it do
      expect(bank_account).to have_attributes(
        merchant_id: 'AV76FTXT15L',
        bank_name: 'Chase',
        name: 'Dave\'s Business Account',
        type: 'CHECKING',
        routing_number: '012345678',
        account_number_suffix: '1234',
        currency_code: 'USD'
      )
    end
  end
end