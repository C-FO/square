require 'spec_helper'

# class for test
class CleanRoomForUtilsTest < OpenStruct
  def self.from_response(response)
    self.new
  end
end unless defined?(CleanRoomForUtilsTest)

describe Square::Utils::API do
  before do
    @clean_room = Class.new
    class << @clean_room
      include Square::Utils::API

      def stub_get(path, options = {})
        { body: {} }
      end

      def stub_get_for_array(path, options = {})
        { body: [], response_headers: {} }
      end
    end
  end

  describe '#objects_from_response' do
    subject(:response) { @clean_room.send(:objects_from_response, CleanRoomForUtilsTest, :stub_get_for_array, '/square') }

    it 'returns an array of instances of passed klass' do
      expect(response[:objects].count).to eq(response.select { |v| v.kind_of?(CleanRoomForUtilsTest) }.count)
    end
  end
  describe '#objects_from_array' do
    subject(:response) { @clean_room.send(:objects_from_array, CleanRoomForUtilsTest, [{ a: 1 }, { b: 2 }]) }

    it 'returns an instance of passed klass' do
      expect(response.count).to eq(response.select { |v| v.kind_of?(CleanRoomForUtilsTest) }.count)
    end
  end
  describe '#object_from_response' do
    subject(:response) { @clean_room.send(:object_from_response, CleanRoomForUtilsTest, :stub_get, '/square') }

    it 'returns an instance of passed klass' do
      expect(response).to be_instance_of(CleanRoomForUtilsTest)
    end
  end

  describe '#path_with_version' do
    before { @clean_room.instance_variable_set(:@api_version, 1) }
    subject { @clean_room.send(:path_with_version, '/square') }
    it 'returns a path string with the correct version' do
      is_expected.to eq('v1/square')
    end
  end

  describe '#parse_date' do
    subject { @clean_room.send(:parse_date, argument) }

    context 'with a string argument' do
      let(:argument) { '2013/01/01' }
      it 'returns the correct date string' do
        is_expected.to eq('2013-01-01')
      end
    end

    context 'with a date argument' do
      let(:argument) { Date.new(2013, 1, 1) }
      it 'returns the correct date string' do
        is_expected.to eq('2013-01-01')
      end
    end

    context 'with an invalid argument' do
      let(:argument) { 1 }
      it 'raises ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#parse_next_link_params' do
    let(:response_header_link) { "Link: <https://connect.squareup.com/v1/me/payments?#{next_link_params_str}>;rel='next'" }
    let(:next_link_params_str) { "begin_time=2014-01-01T14%3A59%3A59%2B00%3A00&end_time=2014-12-30T20%3A59%3A59Z&batch_token=#{batch_token_str}" }
    let(:batch_token_str) { 'LoremipsumdolorsitametconsecteturadipisicingelitseddoeiusmodtemporincididuntutlaboreetdoloremagnaaliquaUtenimadminimveniamquisnostrudexeitationullamcolabo%3D%3D' }

    subject { @clean_room.send(:parse_next_link_params, response_header_link) }
    it 'returns the correct next link params string' do
      is_expected.to eq(next_link_params_str)
    end
  end
end
