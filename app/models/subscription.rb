class Subscription < ActiveRecord::Base
  attr_accessible :plan_id, :user_id, :stripe_card_token
   
  def save_with_payment_on_stripe(user, card_token, plan)
    if valid?
      charge = Stripe::Charge.create(
        :amount => 5*100, # amount in cents, again
        :currency => "usd",
        :card => card_token,
        :description => "Payment for subscription"
      )

      if charge[:paid] === true
        begin
          self.plan_id = plan
          self.stripe_card_token = card_token
          self.save
          return true
        rescue Exception => e
          return true
        end
      else
        errors.add(:base, charge[:failure_message])
        return false
      end
    else
      return false
    end

    rescue Stripe::InvalidRequestError => e
    rescue Exception => e
    end

end
