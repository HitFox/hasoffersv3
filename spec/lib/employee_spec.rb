require 'spec_helper'

describe HasOffersV3::Employee do
  subject { HasOffersV3::Employee }

  let(:url)  { api_url 'Employee' }

  before(:each) do |example|
    stub_call unless example.metadata[:no_stub]
  end

  describe '.find_all' do
    it 'should make a proper request call' do
      response = subject.find_all
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll'}))).to have_been_made
      validate_call response
    end
  end

  describe '.find_all_by_ids' do
    it 'should make a proper request call' do
      response = subject.find_all_by_ids ids: [1]
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAllByIds'}))).to have_been_made
      validate_call response
    end

    context 'when there is no id' do
      it 'should raise exception' do
        expect { subject.find_all_by_ids }.to raise_error ArgumentError
      end
    end
  end

  describe '.find_by_id' do
    it 'should make a proper request call' do
      response = subject.find_by_id id: 1
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findById', 'id' => '1'}))).to have_been_made
      validate_call response
    end

    context 'when there is no id' do
      it 'should raise exception' do
        expect { subject.find_by_id }.to raise_error ArgumentError
      end
    end
  end
end
