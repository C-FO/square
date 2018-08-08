require 'spec_helper'

describe Square::Connect::API::Settlements do
  let(:client) { Square::Connect::Client.new }
  let(:headers) { { content_type: 'application/json; charset=utf-8' } }
  before do
    stub_get(:connect, path).to_return(
      body: fixture(file),
      headers: headers
    )
  end
  after { WebMock.reset! }

  describe '#settlement' do
    subject { client.settlement(1) }

    let(:file) { 'settlement.json' }
    let(:path) { 'v1/me/settlements/1' }


    it do
      is_expected.to be_instance_of(Square::Connect::Settlement)
      expect(assert_request_requested a_get(:connect, path)).to be_nil
    end
  end

  describe '#settlements' do
    subject { client.settlements }

    let(:file) { 'settlements.json' }
    let(:path) { 'v1/me/settlements' }
    it do
      is_expected.to all(be_instance_of(Square::Connect::Settlement))
      expect(assert_request_requested a_get(:connect, path)).to be_nil
    end
  end
end
