require 'spec_helper'

describe Square::Error::ServerError do
  describe '#initialize' do
    subject { described_class.new(message) }
    let(:message) { 'test' }
    context 'when has message' do
      it { expect(subject.message).to eq(message) }
    end
    context 'when has not message' do
      let(:message) { nil }
      it { expect(subject.message).to eq(described_class::MESSAGE) }
    end
  end
end
