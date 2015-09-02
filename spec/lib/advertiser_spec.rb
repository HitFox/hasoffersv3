require 'spec_helper'

describe HasOffersV3::Advertiser do
  subject { HasOffersV3::Advertiser.new }

  let(:url)  { api_url 'Advertiser' }

  describe '.find_all' do
    it 'should make a proper request call' do
      stub_call
      response = subject.find_all
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll'}))).to have_been_made
      validate_call response
    end
  end

  describe '.find_all_ids' do
    it 'should make a proper request call' do
      stub_call
      response = subject.find_all_ids
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAllIds'}))).to have_been_made
      validate_call response
    end
  end

  describe '.find_by_id' do
    it 'should make a proper request call' do
      stub_call
      response = subject.find_by_id id: 1
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findById', 'id' => '1'}))).to have_been_made
      validate_call response
    end

    context 'when there is no id' do
      it 'should raise exception' do
        expect { subject.find_by_id failed_id: 1 }.to raise_error ArgumentError
      end
    end
  end
end
