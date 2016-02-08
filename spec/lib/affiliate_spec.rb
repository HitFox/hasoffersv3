require 'spec_helper'

describe HasOffersV3::Affiliate do
  subject { HasOffersV3::Affiliate }

  let(:url)  { api_url 'Affiliate' }

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

  describe '.find_by_id', :no_stub do
    it 'should make a proper request call' do
      stub_call :post, nil, Regexp.new(url)
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

  describe '.update_payment_method_wire' do
    it 'should make a proper request call' do
      response = subject.update_payment_method_wire
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'updatePaymentMethodWire'}))).to have_been_made
      validate_call response
    end
  end

  describe '.update_payment_method_paypal' do
    it 'should make a proper request call' do
      response = subject.update_payment_method_paypal
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'updatePaymentMethodPaypal'}))).to have_been_made
      validate_call response
    end
  end

  describe 'create' do
    context 'when required params are missing' do
      it 'should fail without data' do
        expect { subject.create }.to raise_error ArgumentError
      end
      it 'should fail without data["company"]' do
        expect { subject.create data: { zipcode: 1234567 }}.to raise_error ArgumentError
      end
      it 'should fail without data["zipcode"]' do
        expect { subject.create data: { company: 'xyz@applift.com' }}.to raise_error ArgumentError
      end
    end

    it 'should make a successful request call' do
      response = subject.create data: { company: "xyz@gmail.com", zipcode: "10178" }
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'create', 'data' => {'company' => 'xyz@gmail.com',
       'zipcode' => '10178'}}))).to have_been_made
      validate_call response
    end
  end

  describe '.get_affiliate_tier' do
    it 'should make a proper request call' do
      stub_call
      response = subject.get_affiliate_tier id: 1
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'getAffiliateTier','id' => '1'}))).to have_been_made
      validate_call response
    end

    it 'should fail without id' do
      expect { subject.get_tier }.to raise_error ArgumentError
    end
  end

end
