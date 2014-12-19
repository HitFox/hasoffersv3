require 'spec_helper'

describe HasOffersV3::Offer do
  subject { HasOffersV3::Offer }

  let(:url)  { api_url 'Offer' }

  describe '.find_all' do
    it 'should make a proper request call' do
      stub_call
      response = HasOffersV3::Offer.find_all
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll'}))).to have_been_made
      validate_call response
    end
  end

  describe '.find_all_by_ids' do
    it 'should make a proper request call' do
      stub_call
      response = HasOffersV3::Offer.find_all_by_ids ids: [1]
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAllByIds'}))).to have_been_made
      validate_call response
    end

    context 'when there is no id' do
      it 'should raise exception' do
        expect { HasOffersV3::Offer.find_all_by_ids }.to raise_error ArgumentError
      end
    end
  end

  describe '.find_all_ids_by_advertiser_id' do
    it 'should make a proper request call' do
      stub_call
      response = HasOffersV3::Offer.find_all_ids_by_advertiser_id advertiser_id: 1
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAllIdsByAdvertiserId', 'advertiser_id' => '1'}))).to have_been_made
      validate_call response
    end

    context 'when there is no id' do
      it 'should raise exception' do
        expect { HasOffersV3::Offer.find_all_ids_by_advertiser_id }.to raise_error ArgumentError
      end
    end
  end

  describe '.find_by_id' do
    it 'should make a proper request call' do
      stub_call
      response = HasOffersV3::Offer.find_by_id id: 1
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findById', 'id' => '1'}))).to have_been_made
      validate_call response
    end

    context 'when there is no id' do
      it 'should raise exception' do
        expect { HasOffersV3::Offer.find_by_id }.to raise_error ArgumentError
      end
    end
  end

  describe '.get_groups' do
    it 'should make a proper request call' do
      stub_call
      response = HasOffersV3::Offer.get_groups id: 1
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'getGroups'}))).to have_been_made
      validate_call response
    end

    context 'when there is no id' do
      it 'should raise exception' do
        expect { HasOffersV3::Offer.get_groups }.to raise_error ArgumentError
      end
    end
  end

  describe '.get_approved_affiliate_ids' do
    it 'makes a proper API request' do
      stub_call
      response = HasOffersV3::Offer.get_approved_affiliate_ids id: 1
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'getApprovedAffiliateIds'}))).to have_been_made
      validate_call response
    end

    context 'when id parameter is missed' do
      it 'raises an exception' do
        expect {  HasOffersV3::Offer.get_approved_affiliate_ids }.to raise_error ArgumentError
      end
    end
  end

  describe '.set_payout' do
    it 'should make a proper request call' do
      stub_call
      response = HasOffersV3::Offer.set_payout id: 1, affiliate_id: 321
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'setPayout'}))).to have_been_made
      validate_call response
    end

    context 'when the id and/or affiliate id parameters are missing' do
      it 'raises an exception' do
        expect {  HasOffersV3::Offer.set_payout }.to raise_error ArgumentError
      end
    end
  end

  describe '.remove_payout' do
    it 'should make a proper request call' do
      stub_call
      response = HasOffersV3::Offer.remove_payout id: 1, affiliate_id: 321
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'removePayout'}))).to have_been_made
      validate_call response
    end

    context 'when the id and/or affiliate id parameters are missing' do
      it 'raises an exception' do
        expect {  HasOffersV3::Offer.remove_payout }.to raise_error ArgumentError
      end
    end
  end
end
