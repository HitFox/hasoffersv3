describe HasOffersV3::Affiliate do
  let(:url)  { api_url 'Affiliate' }

  before(:each) do |example|
    stub_call unless example.metadata[:no_stub]
  end

  describe '#find_all' do
    it 'makes a proper request call' do
      response = subject.find_all
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll'}))).to have_been_made
      validate_call response
    end
  end

  describe '#find_by_id', :no_stub do
    it 'makes a proper request call' do
      stub_call :get, nil, Regexp.new(url)
      response = subject.find_by_id id: 1
      expect(a_request(:get, url).with(query: hash_including({'Method' => 'findById', 'id' => '1'}))).to have_been_made
      validate_call response
    end

    context 'when there is no id' do
      it 'raises exception' do
        expect { subject.find_by_id failed_id: 1 }.to raise_error ArgumentError
      end
    end
  end

  describe '#update' do
    it 'makes a proper request call' do
      response = subject.update id: 1, data: {}
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'update'}))).to have_been_made
      validate_call response
    end

    context 'when required params are missing' do
      it 'fails without id' do
        expect { subject.create data: {} }.to raise_error ArgumentError
      end

      it 'fails without data' do
        expect { subject.create id: 1 }.to raise_error ArgumentError
      end
    end
  end

  describe '#update_payment_method_wire' do
    it 'makes a proper request call' do
      response = subject.update_payment_method_wire
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'updatePaymentMethodWire'}))).to have_been_made
      validate_call response
    end
  end

  describe '#update_payment_method_paypal' do
    it 'makes a proper request call' do
      response = subject.update_payment_method_paypal
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'updatePaymentMethodPaypal'}))).to have_been_made
      validate_call response
    end
  end

  describe '#create' do
    context 'when required params are missing' do
      it 'fails without data' do
        expect { subject.create }.to raise_error ArgumentError
      end
      it 'fails without data["company"]' do
        expect { subject.create data: { zipcode: 1234567 }}.to raise_error ArgumentError
      end
      it 'fails without data["zipcode"]' do
        expect { subject.create data: { company: 'xyz@applift.com' }}.to raise_error ArgumentError
      end
    end

    it 'makes a successful request call' do
      response = subject.create data: { company: "xyz@gmail.com", zipcode: "10178" }
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'create', 'data' => {'company' => 'xyz@gmail.com',
       'zipcode' => '10178'}}))).to have_been_made
      validate_call response
    end
  end

  describe '#get_tier' do
    it 'makes a proper request call' do
      stub_call
      response = subject.get_tier id: 1
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'getAffiliateTier','id' => '1'}))).to have_been_made
      validate_call response
    end

    it 'fails without id' do
      expect { subject.get_tier }.to raise_error ArgumentError
    end
  end

end
