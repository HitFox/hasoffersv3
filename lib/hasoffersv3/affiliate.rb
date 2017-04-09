class HasOffersV3
  class Affiliate < Base
    def find_all(params = {})
      post_request 'findAll', params
    end

    def find_by_id(params = {})
      requires! params, [:id]
      get_request 'findById', params
    end

    def update(params = {})
      requires! params, [:id, :data]
      post_request 'update', params
    end

    def update_payment_method_wire(params = {})
      post_request 'updatePaymentMethodWire', params
    end

    def update_payment_method_paypal(params = {})
      post_request 'updatePaymentMethodPaypal', params
    end

    def create (params = {})
      requires! params, [:data]
      requires! params[:data], [:zipcode, :company]
      post_request 'create', params
    end

    def get_tier(params = {})
      requires! params, [:id]
      post_request 'getAffiliateTier', params
    end

    def get_signup_answers(params = {})
      requires! params, [:id]
      post_request 'getSignupAnswers', params
    end
  end
end
