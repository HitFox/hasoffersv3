require 'net/http' if RUBY_VERSION < '2'
require 'active_support/core_ext/object/to_query'

class HasOffersV3
  class Base
    attr_reader :target

    def initialize(target)
      @target = target
      @client = HasOffersV3.client
    end

    def method_missing(name, *args, &block)
      requires!(name, args.first || {}) if check_presence?(name)

      capitalized_words = name.to_s.split('_').map(&:capitalize)
      camelized_name = "#{capitalized_words.shift.downcase}#{capitalized_words.join}"
      post_request camelized_name, *args, &block
    end

    def post_request(method, params = {}, &block)
      if block.nil?
        make_request(:post, method, params)
      else
        page = 1
        begin
          response = make_request(:post, method, params.merge(page: page))
          block.call response
          page += 1
        end until page > (response.page_info['page_count'] || 1)
      end
    end

    def client
      @client
    end

    private
    def make_request(http_method, method, params)
      @client.request(http_method, target, method, params)
    end

    def check_presence?(name)
      target_presence && target_presence.include?(name.to_s)
    end

    def requires!(name, hash)
      missing_params = target_presence[name.to_s].inject([]) do |a, arg|
        arg = arg.is_a?(String) ? [arg] : arg.flatten!
        diff = arg.map(&:to_sym) - deep_keys(hash)
        a << diff unless diff.empty?
        a
      end.flatten!

      unless missing_params.nil?
        raise ArgumentError.new("Missing required parameter(s): #{missing_params.join(', ')}")
      end
    end

    def target_presence
      Configuration.presence[underscore(@target.to_s)]
    end

    def underscore(str)
      str.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    def deep_keys(hash, array = [])
      return array unless hash.is_a?(Hash)
      hash.keys.each { |k| array << k }
      hash.values.each { |v| deep_keys(v, array) }
      array
    end
  end
end
