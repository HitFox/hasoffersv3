class HasOffersV3
  class Goal < Base
    def find_all(params = {})
      post_request 'findAll', params
    end

    def get_tier_payouts(params = {})
      post_request 'getTierPayouts', params
    end
  end
end
