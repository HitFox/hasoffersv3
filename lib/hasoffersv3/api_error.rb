# frozen_string_literal: true
require 'hasoffersv3/error'

class HasOffersV3
  # Any error emitted at business logic level of the HasOffersV3 API that is not fatal but tells that a particular operation cannot be performed.
  class APIError < ResponseError
    class << self
      def from_response(response)
        error_class_chain.each do |error_class|
          err_msg = error_class.detect(response)
          break error_class.new(err_msg, response) if err_msg
        end
      end

      protected

      def error_class_chain
        # the order is important, more "blocker-like" errors go before "lax" ones; don't forget to add any new error classes to this chain
        @error_class_chain ||= [IPNotWhitelistedError, MissingParamError, FieldError, InternalError, UnknownError]
      end
    end
  end

  class IPNotWhitelistedError < APIError
    def self.detect(response)
      response.error_messages.grep(/IP \d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3} is not white-listed/).first
    end
  end

  class MissingParamError < APIError
    def self.detect(response)
      response.error_messages.grep(/Missing required argument/).first
    end
  end

  class FieldError < APIError
    def self.detect(response)
      response.error_messages.grep(/Field '.*' does not exist or is not allowed to be used./).first
    end
  end

  class InternalError < APIError
    def self.detect(response)
      # E.g. "There was a database error with the trackable id [SE-5888e90b944af]. Contact support for more assistance."
      response.error_messages.grep(/error with the trackable id/).first
    end
  end

  class UnknownError < APIError
    def self.detect(response)
      response.error_messages.first
    end
  end
end
