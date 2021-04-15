require 'spec_helper'

describe Square::Connect::API::Payments do
  let(:client) { Square::Connect::Client.new }
  let(:headers) { { content_type: 'application/json; charset=utf-8' } }
  before do
    stub_get(:connect, path).to_return(
      body: fixture(file),
      headers: headers
    )
  end
  after { WebMock.reset! }

  describe '#payment' do
    subject { client.payment(1) }

    let(:file) { 'payment.json' }
    let(:path) { 'v1/me/payments/1' }

    it do
      is_expected.to be_instance_of(Square::Connect::Payment)
      expect(assert_request_requested a_get(:connect, path)).to be_nil
      expect(subject.inclusive_tax_money.amount).to eq 20
      expect(subject.surcharges.size).to eq 1
      expect(subject.surcharges[0].name).to eq 'Shipping'
    end
  end

  describe '#payments' do
    subject { client.payments }

    let(:file) { 'payments.json' }
    let(:path) { 'v1/me/payments' }
    it do
      is_expected.to all(be_instance_of(Square::Connect::Payment))
      expect(assert_request_requested a_get(:connect, path)).to be_nil
    end
  end
end