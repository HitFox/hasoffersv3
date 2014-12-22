class HasOffersV3
  class Testing
    class << self
      attr_accessor :__test_mode, :__prepared_request

      def enable!
        self.__test_mode = :enabled
      end

      def disable!
        self.__test_mode = :disabled
      end

      def enabled?
        self.__test_mode == :enabled
      end

      def disabled?
        self.__test_mode == :disabled
      end

      def stub_request(status = 200, body = '{"response":{"status":1,"data":[]}}', message = 'mock')
        self.__prepared_request =
          begin
            response = Net::HTTPResponse.new '1.1', status, message
            allow(response).to receive_message(:body).and_return(body)
            response
          end
      end

      def execute_stubbed_request
        current_request = self.__prepared_request || self.stub_request
        self.__prepared_request = nil
        current_request
      end
    end
  end

  class Client
    alias_method :original_execute_request, :execute_request

    def execute_request(net_http, raw_request)
      if HasOffersV3::Testing.enabled?
        HasOffersV3::Testing.execute_stubbed_request
      else
        original_execute_request net_http, raw_request
      end
    end
  end
end
