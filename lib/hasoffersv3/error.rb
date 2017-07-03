# frozen_string_literal: true
require 'active_support/core_ext/module/delegation'

class HasOffersV3
  class Error < StandardError; end

  class ResponseError < Error
    attr_reader :response
    delegate :http_status_code, :http_message, :http_headers, to: :response

    def initialize(message, response)
      super(message)
      @response = response
    end
  end

  class ParseError < ResponseError; end

  class HTTPError < ResponseError
    def self.from_response(response)
      new("HTTP error: #{response.http_message}", response)
    end
  end
end
