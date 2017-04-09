class HasOffersV3
  class Advertiser < Base
    def find_all_ids
      post_request 'findAllIds', {}
    end

    def find_all(params = {})
      post_request 'findAll', params
    end

    def find_by_id(params = {})
      requires! params, [:id]
      post_request 'findById', params
    end

    def get_signup_answers(params = {})
      requires! params, [:id]
      post_request 'getSignupAnswers', params
    end
  end
end
