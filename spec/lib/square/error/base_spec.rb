require 'spec_helper'

describe Square::Error::Base do
  describe '.descendants' do
    subject { described_class.descendants }

    let(:select_descendants) { subject.select { |d| d < Square::Error::Base } }
    it 'returns and array of Square::Error::*' do
      expect(subject.count).to eq(select_descendants.count)
    end
  end

  describe '#initialize' do
    subject do
      begin
        raise TestError.new('error occurred!') rescue raise Square::Error::Base
      rescue Square::Error::Base => ex
        ex
      end
    end
    describe 'wraps another ErrorClass' do
      before do
        class TestError < RuntimeError
        end unless defined? TestError
      end

      it 'error message' do
        expect(subject.message).to eq('error occurred!')
      end

      it 'wrapped exception' do
        expect(subject.wrapped_exception).to be_instance_of(TestError)
      end
    end
  end
end
