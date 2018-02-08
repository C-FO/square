require 'test_helper'

describe Square::Connect::API::Locations do
  let(:client) { Square::Connect::Client.new }

  describe '#locations' do
    before do
      stub_get(:connect, 'v1/me/locations').to_return(body: fixture('locations.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    let(:locations) { client.locations }

    after { WebMock.reset! }

    it 'requests the correct resource' do
      locations
      assert_request_requested a_get(:connect, 'v1/me/locations')
    end

    it 'returns an array of instances of Square::Connect::Location' do
      locations.count.must_equal locations.count {|x| x.is_a? Square::Connect::Location}
    end
  end

end
