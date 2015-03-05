require 'test_helper'

describe Square::Utils::API do
  before do
    class CleanRoomForUtilsTest < OpenStruct
      def self.from_response(response); self.new; end
    end unless defined? CleanRoomForUtilsTest

    @clean_room = Class.new

    class << @clean_room
      include Square::Utils::API

      def stub_get(path, options={})
        {body: {}}
      end

      def stub_get_for_array(path, options={})
        {body: [], response_headers: {}}
      end
    end
  end

  describe '#objects_from_response' do
    it 'returns an array of instances of passed klass' do
      response = @clean_room.send(:objects_from_response, CleanRoomForUtilsTest, :stub_get_for_array, '/square')[:objects]
      response.size.must_equal response.select {|v| v.is_a? CleanRoomForUtilsTest}.size
    end
  end

  describe '#objects_from_array' do
    it 'returns an array of instances of passed klass' do
      response = @clean_room.send(:objects_from_array, CleanRoomForUtilsTest, [{a: 1}, {b: 2}])
      response.size.must_equal response.select {|v| v.is_a? CleanRoomForUtilsTest}.size
    end
  end

  describe '#object_from_response' do
    it 'returns an instance of passed klass' do
      @clean_room.send(:object_from_response, CleanRoomForUtilsTest, :stub_get, '/square').must_be_instance_of CleanRoomForUtilsTest
    end
  end

  describe '#path_with_version' do
    it 'returns a path string with the correct version' do
      @clean_room.instance_eval { @api_version = 1 }
      @clean_room.send(:path_with_version, '/square').must_equal 'v1/square'
    end
  end

  describe '#parse_date' do

    describe 'with a string argument' do
      it 'returns the correct date string' do
        @clean_room.send(:parse_date, '2013/01/01').must_equal '2013-01-01'
      end
    end

    describe 'with a date argument' do
      it 'returns the correct date string' do
        @clean_room.send(:parse_date, Date.new(2013, 1, 1)).must_equal '2013-01-01'
      end
    end

    describe 'with an invalid argument' do
      it 'raise ArgumentError' do
        -> { @clean_room.send(:parse_date, 1) }.must_raise ArgumentError
      end
    end
  end

  describe '#parse_batch_token' do
    let(:response_header_link){
      "Link: <https://connect.squareup.com/v1/me/payments?begin_time=2014-01-01T14%3A59%3A59%2B00%3A00&end_time=2014-12-30T20%3A59%3A59Z&batch_token=#{batch_token_str}>;rel='next'"
    }
    let(:batch_token_str){
      'LoremipsumdolorsitametconsecteturadipisicingelitseddoeiusmodtemporincididuntutlaboreetdoloremagnaaliquaUtenimadminimveniamquisnostrudexeitationullamcolabo%3D%3D'
    }

    it 'returns the correct batch token string' do
      @clean_room.send(:parse_batch_token, response_header_link).must_equal batch_token_str
    end
  end
end
