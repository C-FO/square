require 'spec_helper'

describe Hash do
  describe '#deep_symbolize_keys' do
    subject { hash.deep_symbolize_keys }

    let(:hash) do
      {
        'a' => 1,
        'b' => {
          'c' => 1
        }
      }
    end

    context 'when hash => [:a]' do
      it { expect(subject[:a]).to eq(1) }
    end
    context 'when hash => [:b]' do
      it { expect(subject[:b]).to eq({ c: 1 }) }
    end
  end
end