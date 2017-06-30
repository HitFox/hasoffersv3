# frozen_string_literal: true
require 'hasoffersv3/error'

describe HasOffersV3::Client do
  let(:config) { HasOffersV3::Configuration.new }
  subject {  HasOffersV3::Client.new(config) }

  describe '#new_http' do
    context 'when configuration proxy_host is present' do
      let(:config) do
        result = HasOffersV3::Configuration.new
        result.proxy_host = 'proxy.com'
        result.proxy_port = '8080'
        result
      end

      it 'generates a connection with proxy' do
        http_client = subject.new_http(URI('http://hasoffers.com:9300/'))
        expect(http_client.proxyaddr).to eq('proxy.com')
        expect(http_client.proxyport).to eq('8080')
      end
    end
  end

  describe '#request' do
    context 'raising errors' do
      let(:raise_errors) { true }

      shared_examples 'does not raise errors when setting is not applied' do
        let(:raise_errors) { false }

        it 'does not raise errors' do
          expect { subject }.not_to raise_error
        end
      end

      let(:config) { HasOffersV3::Configuration.new(raise_errors: raise_errors) }

      context 'HTTP errors' do
        let(:url)  { api_url 'Advertiser' }
        let(:response) do
          {
            body: 'null',
            headers: { 'Content-Length' => 0, 'Connection' => 'Close' },
            status: [504, 'GATEWAY_TIMEOUT']
          }
        end
        let(:http_method) { :post }

        it 'raises an appropriate error when HTTP failure detected' do
          stub_call(http_method, response)

          expect { subject.request(http_method, 'Advertiser', 'findAll', {}) }.to raise_error do |error|
            expect(error).to be_a(HasOffersV3::HTTPError)
            expect(error).to have_attributes(
                               message: 'HTTP error when accessing HOv3API',
                               http_status_code: '504',
                               http_message: 'GATEWAY_TIMEOUT',
                               http_headers: {
                                 'content-length' => ['0'],
                                 'connection' => ['Close']
                               }
                             )
          end
        end

        it_behaves_like 'does not raise errors when setting is not applied'
      end
    end
  end

  describe '#base_uri' do
    let(:configuration_to_default_host) { HasOffersV3::Configuration.new }
    let(:config_for_proxy) {
      result = HasOffersV3::Configuration.new
      result.host = 'api.applift.com'
      result
    }

    it 'has different configs' do
      default_connection = HasOffersV3::Client.new(configuration_to_default_host)
      expect(default_connection.base_uri).to eq('https://api.hasoffers.com/v3')

      proxy_connection = HasOffersV3::Client.new(config_for_proxy)
      expect(proxy_connection.base_uri).to eq('https://api.applift.com/v3')
    end
  end
end
