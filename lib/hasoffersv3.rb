require 'net/http'
require 'json'

require 'hasoffersv3/client'

%w!base affiliate response conversion raw_log report configuration advertiser advertiser_user offer offer_pixel employee application goal logger!.each do |file|
  require "hasoffersv3/#{file}"
end

require 'hasoffersv3/advertiser_billing'
require 'hasoffersv3/affiliate_offer'
require 'hasoffersv3/affiliate_billing'

class HasOffersV3

  API_TARGETS = {
    advertisers: HasOffersV3::Advertiser,
    advertiser_users: HasOffersV3::AdvertiserUser,
    advertiser_billing: HasOffersV3::AdvertiserBilling,
    affiliates: HasOffersV3::Affiliate,
    affiliate_offers: HasOffersV3::AffiliateOffer,
    affiliate_billing: HasOffersV3::AffiliateBilling,
    conversions: HasOffersV3::Conversion,
    employee: HasOffersV3::Employee,
    offers: HasOffersV3::Offer,
    offer_pixels: HasOffersV3::OfferPixel,
    raw_logs: HasOffersV3::RawLog,
    reports: HasOffersV3::Report,
    application: HasOffersV3::Application,
    goal: HasOffersV3::Goal
  }

  class << self

    def configuration=(config)
      @configuration = config
    end

    def configuration
      @configuration ||= ::HasOffersV3::Configuration.new
    end

    def configure &block
      yield(configuration)
    end

    def client
      ::HasOffersV3::Client.new(configuration)
    end
  end

  def configuration
    @configuration ||= ::HasOffersV3.configuration
  end

  def configure(&block)
    yield(configuration)
  end

  def initialize(options = {})
    @options = options.dup
    @configuration = ::HasOffersV3::Configuration.new options
  end

  def client
    ::HasOffersV3::Client.new(@configuration)
  end

  API_TARGETS.each do |name, target|
    define_method name do
      target.new(client)
    end
  end

end

if ENV['RAILS_ENV'] == 'test' ||  ENV['RACK_ENV'] == 'test' || ENV['TEST']
  require 'hasoffersv3/testing'
  HasOffersV3::Testing.enable!
end
