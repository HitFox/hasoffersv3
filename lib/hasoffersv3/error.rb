# frozen_string_literal: true
require 'active_support/core_ext/module/delegation'

class HasOffersV3
  class Error < StandardError; end

  class ResponseParseError < Error; end

  class HTTPError < Error
    delegate :http_status_code, :http_message, :http_headers, to: :@response

    def self.from_response(response)
      new('HTTP error when accessing HOv3API', response)
    end

    def initialize(message, response)
      super(message)
      @response = response
    end
  end

  class APIError < Error


  end
  class IPNotWhitelisted < APIError; end
  class DatabaseError < APIError; end
  class UnknownError < APIError; end
end
