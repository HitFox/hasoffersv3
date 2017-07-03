class HasOffersV3
  class Response
    attr_reader :body, :http_status_code, :http_message, :http_headers

    def initialize(response, json=default_json_driver)
      begin
        @body = json.load(response.body.to_s)
      rescue
        raise ParseError.new('Error parsing response body, examine the `cause` property for details', response)
      end

      @http_status_code = response.code
      @http_message     = response.message
      @http_headers     = response.to_hash
    end

    def success?
      http_ok? && status_ok?
    end

    def http_ok?
      @http_status_code.to_s == '200'
    end

    def status_ok?
      status == 1
    end

    def status
      @body['response']['status']
    end

    def raw_data
      @body
    end

    # allows specific api calls to post-process the data for ease of use
    def set_data(data)
      @processed_data = data
    end

    def data
      @processed_data || (paginated_response? ? @body['response']['data']['data'] : @body['response']['data'])
    end

    def page_info
      if paginated_response?
        {
          'page_count'  => @body['response']['data']['pageCount'],
          'current'     => @body['response']['data']['current'],
          'count'       => @body['response']['data']['count'],
          'page'        => @body['response']['data']['page']
        }
      else
        {}
      end
    end

    def validation_error?
      status == -1 and data['error_code'] == 1
    end

    def error_messages
      if data.is_a? Hash and data["errors"] and data["errors"]["error"]
        get_error_values data["errors"]["error"]
      elsif @body["response"]["errors"]
        get_error_values @body["response"]["errors"]
      else
        []
      end
    end

    protected
    def paginated_response?
      @body['response']['data'] and @body['response']['data'].is_a?(Hash) and @body['response']['data'].has_key?('pageCount')
    end

    private
    def get_error_values(obj)
      if obj.is_a? Hash
        obj.values
      elsif obj.is_a? Array
        obj.map { |error| error["err_msg"] || error["publicMessage"] }
      end
    end

    def default_json_driver
      @_default_json_driver ||= ::HasOffersV3::Configuration.default_json_driver
    end

  end
end
