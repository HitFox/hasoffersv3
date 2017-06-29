# frozen_string_literal: true
class HasOffersV3
  class Error < StandardError; end

  class ResponseParseError < Error; end
  class HTTPError < Error; end
  class APIError < Error; end

  class IPNotWhitelisted < APIError; end
  class DatabaseError < APIError; end
  class UnknownError < APIError; end
end
