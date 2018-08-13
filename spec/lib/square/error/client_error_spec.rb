require 'spec_helper'

describe Square::Error::ClientError do
  describe '.from_response' do
    subject { described_class.from_response(body: body).message }

    context 'when body is nil' do
      let(:body) { nil }

      it { is_expected.to eq('') }
    end
    context 'when body has string' do
      let(:body) { 'abc' }

      it { is_expected.to eq('abc') }
    end
    context 'when body has hash' do
      context 'body[:error] = String' do
        let(:body) { { error: 'abc' } }

        it { is_expected.to eq('abc') }
      end
      context 'body[:errors] = Array[Hash]' do
        let(:body) { { errors: [{ message: 'a' }, { message: 'b' }, { message: 'c' }] } }

        it { is_expected.to eq('a') }
      end
      context 'body[errors] = Array[String]' do
        let(:body) { { errors: ['a', 'b', 'c'] } }

        it { is_expected.to eq('a') }
      end
    end
  end
end
