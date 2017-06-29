# frozen_string_literal: true
require 'hasoffersv3/error'

describe HasOffersV3::Response do
  describe '#initialize' do
    it 'raises an appropriate error on malformed response body' do
      expect { described_class.new('"') }.to(
        raise_error(HasOffersV3::ResponseParseError, 'Error parsing response body, examine the `cause` property for details')
      )
    end
  end
end
