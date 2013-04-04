class Subscription < ActiveRecord::Base
  attr_accessible :plan_id, :user_id, :stripe_card_token
  has_one :plan, :dependent => :destroy
  belongs_to :user

  def save_with_payment_on_stripe(user, card_token, plan_id)
    if valid?
      customer = Stripe::Customer.create(email: user.email, plan: plan_id, card: card_token)
      self.stripe_customer_token = customer.id
      self.plan_id = plan_id
      save!
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem processing your credit card: #{e.message}"
    false
  end

end
