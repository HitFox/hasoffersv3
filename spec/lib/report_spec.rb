describe HasOffersV3::Report do
  let(:url)  { api_url 'Report' }

  describe '#get_conversions' do
    before(:each) { stub_call }

    it 'makes a proper request call' do
      response = subject.get_conversions
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'getConversions'}))).to have_been_made
      validate_call response
    end
  end

  describe '#get_mod_summary_logs' do
    let(:url)  { Regexp.new api_url('Report') }

    before(:each) { stub_call :get }

    it 'makes a proper request call' do
      response = subject.get_mod_summary_logs
      expect(a_request(:get, url).with(query: hash_including({'Method' => 'getModSummaryLogs'}))).to have_been_made
      validate_call response
    end
  end

  describe '#get_stats' do
    before(:each) { stub_call }

    it 'makes a proper request call' do
      response = subject.get_stats
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'getStats'}))).to have_been_made
      validate_call response
    end
  end
end
