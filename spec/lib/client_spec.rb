describe HasOffersV3::Client do
  let(:config) { HasOffersV3::Configuration.new }
  subject {  HasOffersV3::Client.new(config) }

  describe '#new_http' do

    context 'when configuration proxy_host is present' do

      let(:config) {
        result = HasOffersV3::Configuration.new
        result.proxy_host = 'proxy.com'
        result.proxy_port = '8080'
        result
      }

      it 'generates a connection with proxy' do
        http_client = subject.new_http(URI('http://hasoffers.com:9300/'))
        expect(http_client.proxyaddr).to eq('proxy.com')
        expect(http_client.proxyport).to eq('8080')
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
