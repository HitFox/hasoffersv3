class HasOffersV3
  class Configuration
    attr_reader :options

    class << self
      def default_json_driver
        @_default_json_driver ||= begin
          return Oj if defined?(Oj)
          return MultiJson if defined?(MultiJson)
          JSON
        end
      end

      def presence
        path = File.expand_path('../../../config/presence.yml', __FILE__)
        YAML.load_file(path)
      end
    end

    DEFAULTS = {
      host: 'api.hasoffers.com',
      protocol: 'https',
      read_timeout: 60,
      base_path: '/v3',
      network_id: '',
      api_key: '',
      json_driver: default_json_driver,
      presence: presence
    }.freeze

    DEFAULTS.keys.each do |option_name|
      define_method option_name do
        @options[option_name]
      end

      define_method "#{option_name}=" do |val|
        @options[option_name] = val
      end
    end

    def initialize(options={})
      defaults = DEFAULTS.dup
      @options = options.dup

      defaults.keys.each do |key|
        # Symbolize only keys that are needed
        @options[key] = @options[key.to_s] if @options.has_key?(key.to_s)
      end

      # Use default when option is not specified or nil
      defaults.keys.each do |key|
        @options[key] = defaults[key] if @options[key].nil?
      end
    end

    def base_uri
      "#{protocol}://#{host}#{base_path}"
    end
  end
end
