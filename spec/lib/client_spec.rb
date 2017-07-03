# frozen_string_literal: true
require 'hasoffersv3/error'
require 'hasoffersv3/api_error'

describe HasOffersV3::Client do
  let(:config) { HasOffersV3::Configuration.new }
  let(:client) { HasOffersV3::Client.new(config) }
  subject { client }

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
      let(:config) { HasOffersV3::Configuration.new(raise_errors: raise_errors) }
      let(:url) { api_url 'Advertiser' }
      let(:response_body) { default_return[:body] }
      let(:status) { default_return[:status] }
      let(:headers) { {} }
      let(:response) do
        {
          body: JSON.dump(response_body),
          status: status,
          headers: headers
        }
      end
      let(:http_method) { :post }

      before { stub_call(http_method, response) }

      subject { client.request(http_method, 'Advertiser', 'findAll', {}) }

      shared_examples 'does not raise errors when setting is not applied' do
        let(:raise_errors) { false }

        it 'does not raise errors' do
          expect { subject }.not_to raise_error
        end
      end

      context 'no errors' do
        it 'does not raise error if no error messages were detected' do

        end
      end

      context 'HTTP errors' do
        let(:response_body) { nil }
        let(:headers) { { 'Content-Length' => 0, 'Connection' => 'Close' } }
        let(:status) { [504, 'GATEWAY_TIMEOUT'] }

        it 'raises an appropriate error when HTTP failure detected' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a HasOffersV3::HTTPError
            expect(error).to have_attributes(
                               message: 'HTTP error: GATEWAY_TIMEOUT',
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

      context 'API errors' do
        shared_examples 'API error is detected and raised' do
          let(:response_body) do
            {
              'response' => {
                'status' => -1,
                'httpStatus' => 200,
                'data' => '',
                'errors' => [{'publicMessage' => error_message }],
                'errorMessage' => error_message
              }
            }
          end

          it 'raises an appropriate error when such an error detected' do
            expect { subject }.to raise_error(error_class, error_message)
          end

          it_behaves_like 'does not raise errors when setting is not applied'
        end

        context 'IP is not whitelisted' do
          let(:error_message) { 'IP 178.161.91.191 is not white-listed. Please enable it in the application, Support => API' }
          let(:error_class) { HasOffersV3::IPNotWhitelistedError }

          it_behaves_like 'API error is detected and raised'
        end

        context 'parameter missing' do
          subject { client.request(http_method, 'Advertiser', 'findById', {}) }

          let(:error_message) { 'Missing required argument: id' }
          let(:error_class) { HasOffersV3::MissingParamError }

          it_behaves_like 'API error is detected and raised'
        end

        context 'field error' do
          let(:url) { api_url 'Report' }
          subject { client.request(http_method, 'Report', 'getStats', { 'fields[]' => 'Offer.nam' }) }

          let(:error_message) { "Field 'Offer.nam' does not exist or is not allowed to be used." }
          let(:error_class) { HasOffersV3::FieldError }

          it_behaves_like 'API error is detected and raised'
        end

        context 'internal error' do
          let(:error_message) { 'There was a database error with the trackable id [SE-5888e90b944af]. Contact support for more assistance.' }
          let(:error_class) { HasOffersV3::InternalError }

          it_behaves_like 'API error is detected and raised'
        end

        context 'unknown error' do
          let(:error_message) { 'Something went wrong.' }
          let(:error_class) { HasOffersV3::UnknownError }

          it_behaves_like 'API error is detected and raised'
        end
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
