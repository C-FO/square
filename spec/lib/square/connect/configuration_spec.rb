require 'spec_helper'

describe Square::Connect::Configuration do
  before do
    @clean_room = Class.new
    class << @clean_room
      include Square::Connect::Configuration
    end
  end

  describe '#configure' do
    it 'returns an instance of the caller class' do
      expect(@clean_room.configure { |config| }).to be_instance_of(Class)
    end
    describe 'api_version' do
      it 'is configurable' do
        @clean_room.configure do |config|
          config.api_version = '1'
        end

        expect(@clean_room.api_version).to eq('1')
      end
    end
  end
  describe '#reset!' do
    subject { @clean_room.reset! }
    before do
      @clean_room.configure do |config|
        config.api_version = '1'
      end

      it 'resets api_version' do
        expect { subject }.to change { @clean_room.api_version }.from('1').to(Square::Connect::Default::API_VERSION)
      end
    end
  end
end
