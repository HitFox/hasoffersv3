require 'spec_helper'

describe HasOffersV3::Conversion do
  subject { HasOffersV3::Conversion }

  let(:url)  { Regexp.new api_url('Conversion') }

  before :each do
    stub_call :post
  end

  describe '.find_all' do
    it 'should make a proper request call' do
      response = subject.find_all
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll'}))).to have_been_made
      validate_call response
    end
  end

  describe '.find_added_conversions' do
    it 'should make a proper request call' do
      response = subject.find_added_conversions
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAddedConversions'}))).to have_been_made
      validate_call response
    end
  end

  describe '.find_updated_conversions' do
    it 'should make a proper request call' do
      response = subject.find_updated_conversions
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findUpdatedConversions'}))).to have_been_made
      validate_call response
    end
  end

  describe '.findAll' do
    it 'should make a proper request call' do
      response = subject.find_all
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll'}))).to have_been_made
      validate_call response
    end

    it 'should call find_all method' do
      expect(subject).to receive(:find_all).with({test: 1})
      subject.find_all test: 1
    end
  end
end
