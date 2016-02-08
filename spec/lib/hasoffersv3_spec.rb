require 'spec_helper'

describe HasOffersV3 do

  context 'singleton' do
    it 'should use default config' do
      subject = HasOffersV3::Offer.client.configuration
      expect(subject).to eq(HasOffersV3.configuration)
    end
  end

  describe '#configuration' do
    it 'should create different connections' do
      subject = HasOffersV3.new
      expect(subject.configuration).to_not eq(HasOffersV3.configuration)
    end

    it 'should use params instead of default' do
      subject = HasOffersV3.new(host: 'example.com')
      expect(subject.configuration.host).to eq('example.com')
      expect(subject.configuration.host).to_not eq(HasOffersV3::Configuration::DEFAULTS[:host])
    end
  end
end

