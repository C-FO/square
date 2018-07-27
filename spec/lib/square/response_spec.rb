require 'spec_helper'

describe Square::Response::RaiseError do

  describe '#on_complete' do
    subject { described_class.new({}, Square::Error::Base).on_complete(status: http_status) }

    [
      [400, Square::Error::BadRequest],
      [401, Square::Error::Unauthorized],
      [403, Square::Error::Forbidden],
      [404, Square::Error::NotFound],
      [406, Square::Error::NotAcceptable],
      [500, Square::Error::InternalServerError],
      [502, Square::Error::BadGateway],
      [503, Square::Error::ServiceUnavailable],
      [504, Square::Error::GatewayTimeout],
    ].each do |http_status, error|
      context "raises #{http_status}: #{error}" do
        let(:http_status) { http_status }

        it { expect { subject }.to raise_error(error) }
      end
    end
  end
end
