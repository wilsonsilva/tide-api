# typed: false
require 'tide/api/auth_server'

RSpec.describe Tide::API::AuthServer do
  let(:response_line) { 'GET /?code=G81h7C2u7YoJUTLogS2VLsEvbwjflmHS HTTP/1.1' }
  let(:tcp_socket)    { instance_spy('TCPSocket', gets: response_line, close: nil) }
  let(:tcp_server)    { instance_spy('TCPServer', accept: tcp_socket, addr: ['', 8080, '']) }
  let(:auth_server)   { described_class.new }

  before do
    allow(TCPServer).to receive(:new).and_return(tcp_server)

    allow(auth_server).to receive(:puts)
    allow(tcp_socket).to receive(:print)
    allow(auth_server).to receive(:system)
  end

  describe '#run' do
    it "opens Tide's authentication page" do
      auth_server.run
      expect(auth_server).to have_received(:system)
    end

    it 'returns an authorization grant code from the HTTP callback' do
      allow(auth_server).to receive(:system)

      auth_grant_code = auth_server.run
      expect(auth_grant_code).to eq('G81h7C2u7YoJUTLogS2VLsEvbwjflmHS')
    end

    it 'renders an HTML page instructing the user to close the page' do
      auth_server.run
      expect(tcp_socket).to have_received(:print).with(described_class::RESPONSE)
    end
  end
end
