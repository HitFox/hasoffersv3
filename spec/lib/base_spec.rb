require 'spec_helper'

describe HasOffersV3::Base do
  subject { HasOffersV3::Base.new(:test) }

  let(:url) { Regexp.new api_url('test') }

  describe ".post_request" do
    it "should make a proper request" do
      stub_call :post
      response = subject.post_request 'test'
      request = a_request(:post, url).with(body: hash_including('Method' => 'test'))
      expect(request).to have_been_made
      validate_call response
    end

    context "with HTTPS enabled" do
      before(:each) do
        @old_protocol = HasOffersV3.configuration.protocol
        HasOffersV3.configuration.protocol = 'https'
      end

      after(:each) do
        HasOffersV3.configuration.protocol = @old_protocol
      end

      it "should make a proper request" do
        stub_call :post
        response = subject.post_request 'test'
        expect(a_request(:post, url).with(body: hash_including('Method' => 'test'))).to have_been_made
        validate_call response
      end
    end
  end
end
