require 'spec_helper'

describe Square::Connect::API::Refunds do
  let(:client) { Square::Connect::Client.new }
  let(:path) { 'v1/me/refunds' }
  let(:headers) { { content_type: 'application/json; charset=utf-8' } }
  describe '#refunds' do
    subject { client.refunds }

    before do
      stub_get(:connect, path).to_return(
        body: fixture('refunds.json'),
        headers: headers
      )
    end
    after { WebMock.reset! }

    it do
      is_expected.to all(be_instance_of(Square::Connect::Refund))
      expect(assert_request_requested a_get(:connect, path)).to be_nil
    end
  end
end
