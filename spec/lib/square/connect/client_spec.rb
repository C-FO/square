require 'spec_helper'

describe Square::Connect::Client do
  describe '#initialize' do
    subject { described_class.new }

    it { is_expected.to be_instance_of(described_class) }
  end
end
