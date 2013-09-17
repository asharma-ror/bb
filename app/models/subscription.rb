class Subscription < ActiveRecord::Base
  attr_accessible :plan_id, :user_id, :end_date, :start_date, :is_active, :canceled_date, :stripe_customer_token, :project_id, :payment_profile_id
  attr_accessor :stripe_card_token
  belongs_to :plan
  belongs_to :user
  belongs_to :project

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

  def self.save_paypal_profile(recurring_profile, project_id, plan_id, user)
     project = user.active_projects.find(project_id)
     subscription = project.subscription
     subscription = subscription.blank? ? self.new : subscription
     subscription.is_active = true
     subscription.start_date = recurring_profile.params["timestamp"]
     subscription.payment_profile_id = recurring_profile.params["profile_id"]
     subscription.project_id = project.id
     subscription.plan_id = plan_id
     subscription.save!
  end
end
