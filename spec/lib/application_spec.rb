require 'spec_helper'

describe HasOffersV3::Application do
  let(:url)  { Regexp.new api_url('Application') }

  describe '.find_all_affiliate_tiers' do
    subject { HasOffersV3::Application }
    it 'should make a proper request call' do
      stub_call :post
      response = subject.find_all_affiliate_tiers
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAllAffiliateTiers'}))).to have_been_made
      validate_call response
    end
  end
end
