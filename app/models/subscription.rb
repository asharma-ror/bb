class Subscription < ActiveRecord::Base
  attr_accessible :plan_id, :user_id, :end_date, :start_date, :is_active, :canceled_date
  attr_accessor :stripe_customer_token
  has_one :plan, :dependent => :destroy
  belongs_to :user

  def save_with_payment_on_stripe(user, card_token, plan_id)
    if valid?
      customer = Stripe::Customer.create(email: user.email, plan: plan_id, card: card_token)
      self.stripe_customer_token = customer.id
      self.plan_id = plan_id
      self.is_active = true
      self.start_date = Time.now
      plan_days = Plan.find(plan_id).days
      self.end_date = Time.now + plan_days.days
      save!
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem processing your credit card: #{e.message}"
    false
  end

end
