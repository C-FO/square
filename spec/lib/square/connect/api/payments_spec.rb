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
      expect(subject.additive_tax_money.amount).to eq 30
      expect(subject.tax_money.amount).to eq 50
      expect(subject.tip_money.amount).to eq 100
      expect(subject.discount_money.amount).to eq 0
      expect(subject.net_total_money.amount).to eq 5981
      expect(subject.swedish_rounding_money.amount).to eq 0
      expect(subject.gross_sales_money.amount).to eq 100
      expect(subject.net_sales_money.amount).to eq 100

      expect(subject.surcharges.size).to eq 1
      expect(subject.surcharges[0].name).to eq 'Shipping'
      expect(subject.surcharges[0].amount_money.amount).to eq 100
      expect(subject.surcharges[0].applied_money.amount).to eq 100
      expect(subject.surcharges[0].taxes).to be_empty
      expect(subject.surcharge_money.amount).to eq 100

      expect(subject.inclusive_tax.size).to eq 1
      expect(subject.additive_tax.size).to eq 1
      expect(subject.tender.size).to eq 1
      expect(subject.refunds.size).to eq 0
      expect(subject.itemizations.size).to eq 1
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