require 'spec_helper'
require 'faraday'

describe Square::Connect::Request do
  before do
    @clean_room = Class.new

    class << @clean_room
      include Square::Connect::Request
    end
    WebMock.enable!
  end
  after { WebMock.reset! }
  let(:query) { { a: '1' } }

  describe '#get' do
    let(:path) { 'square/get' }
    subject { @clean_room.get(path, query) }
    context 'with success result' do
      before { stub_get(:connect, path).with(query: query) }

      it { expect(subject.status).to eq(200) }
    end
    context 'with faraday client error' do
      let(:path) { 'square/error' }
      let(:query) {}
      before { stub_get(:connect, path).to_raise Faraday::Error::ClientError }

      it { expect { subject }.to raise_error Square::Error::ClientError }
    end
  end

  describe '#post' do
    let(:path) { 'square/post' }
    subject { @clean_room.post(path, query) }
    context 'with success result' do
      before { stub_post(:connect, path).with(body: query) }

      it { expect(subject.status).to be(200) }
    end
    context 'with faraday client error' do
      let(:path) { 'square/error' }
      let(:query) {}
      before { stub_post(:connect, path).to_raise Faraday::Error::ClientError }

      it { expect { subject }.to raise_error Square::Error::ClientError }
    end
  end

  describe '#put' do
    let(:path) { 'square/put' }
    subject { @clean_room.put(path, query) }
    context 'with success result' do
      before { stub_put(:connect, path).with(body: query) }

      it { expect(subject.status).to be(200) }
    end
    context 'with faraday client error' do
      let(:path) { 'square/error' }
      let(:query) {}
      before { stub_put(:connect, path).to_raise Faraday::Error::ClientError }

      it { expect { subject }.to raise_error Square::Error::ClientError }
    end
  end

  describe '#delete' do
    let(:path) { 'square/delete' }
    subject { @clean_room.delete(path, query) }
    context 'with success result' do
      before { stub_delete(:connect, path).with(query: query) }

      it { expect(subject.status).to be(200) }
    end
    context 'with faraday client error' do
      let(:path) { 'square/error' }
      let(:query) {}
      before { stub_delete(:connect, path).to_raise Faraday::Error::ClientError }

      it { expect { subject }.to raise_error Square::Error::ClientError }
    end
  end
end
