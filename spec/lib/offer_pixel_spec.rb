require 'spec_helper'

describe HasOffersV3::OfferPixel do
  subject { HasOffersV3::OfferPixel }

  let(:url) { api_url 'OfferPixel' }

  describe '.find_all' do
    it 'should make a proper request call' do
      stub_call
      response = subject.find_all
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll'}))).to have_been_made
      validate_call response
    end

    it 'should contain filters by type and modified' do
      stub_call
      response = subject.find_all(filters: {type: 'url', modified: {'GREATER_THAN' => '2015-01-01+00:00'}})
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll', filters: { type: 'url', modified: {'GREATER_THAN' => '2015-01-01+00:00'} }}))).to have_been_made
      validate_call response
    end

    it 'should sort by modified' do
      stub_call
      response = subject.find_all(sort: {modified: 'asc'})
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll', sort: {modified: 'asc'}}))).to have_been_made
      validate_call response
    end
  end

  describe '.find_all_by_ids' do
    it 'should make a proper request call' do
      stub_call
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
      stub_call
      response = subject.find_by_id id: [1]
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findById'}))).to have_been_made
      validate_call response
    end

    context 'when there is no id' do
      it 'should raise exception' do
        expect { subject.find_by_id }.to raise_error ArgumentError
      end
    end
  end

  describe '.get_allowed_types' do
    it 'should make a proper request call' do
      stub_call
      response = subject.get_allowed_types offer_id: [1]
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'getAllowedTypes'}))).to have_been_made
      validate_call response
    end

    context 'when there is no offer_id' do
      it 'should raise exception' do
        expect { subject.get_allowed_types }.to raise_error ArgumentError
      end
    end
  end

end
