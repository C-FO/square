require 'spec_helper'

describe Square::Connect::API::Merchants do
  let(:client) { Square::Connect::Client.new }
  let(:path) { 'v1/me' }
  let(:headers) { { content_type: 'application/json; charset=utf-8' } }
  describe '#merchant' do
    subject { client.merchant }

    before do
      stub_get(:connect, path).to_return(
        body: fixture('merchant.json'),
        headers: headers
      )
    end
    after { WebMock.reset! }

    it do
      is_expected.to be_instance_of(Square::Connect::Merchant)
      expect(assert_request_requested a_get(:connect, path)).to be_nil
    end
  end
end
