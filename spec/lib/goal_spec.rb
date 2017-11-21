describe HasOffersV3::Goal do
  let(:url)  { api_url 'Goal' }

  describe '#find_all' do
    it 'makes a proper request call' do
      stub_call
      response = subject.find_all
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll'}))).to have_been_made
      validate_call response
    end
  end

  describe '#get_tier_payouts' do
    it 'makes a proper request call' do
      stub_call
      response = subject.get_tier_payouts
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'getTierPayouts'}))).to have_been_made
      validate_call response
    end
  end
end
