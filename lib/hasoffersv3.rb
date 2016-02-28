require 'net/http'
require 'json'
require 'yaml'

%w(configuration client response base).each { |file| require "hasoffersv3/#{file}" }

class HasOffersV3
  class << self
    def const_missing(name)
      Base.new(name.to_s)
    end

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
      @client ||= ::HasOffersV3::Client.new(configuration)
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
    self.client
  end
end
