class HooksController < ApplicationController
  require 'json'
  
  layout "project_task"

  def receiver
    data_json = JSON.parse request.body.read

    make_active(data_json) if data_json['type'] == "invoice.payment_succeeded"

    make_subscription_cancel(data_json) if data_json['type'] == "customer.subscription.deleted"

    make_inactive(data_json) if data_json['type'] == "invoice.payment_failed"

    render :text => "ok"
  end

  def make_active(data)
     subscription = Subscription.find_by_stripe_customer_token(data['data']['object']['customer'])
     if subscription.present?
      cust_subscripton = data['data']['object']['lines']['subscriptions'][0]['period']
      subscription.end_date = Time.at(cust_subscripton['end'].to_i)
      subscription.start_date = Time.at(cust_subscripton['start'].to_i)
      subscription.is_active = true
      subscription.save!
     end
  end

  def make_subscription_cancel(data)
     subscription = Subscription.find_by_stripe_customer_token(data['data']['object']['customer'])
     if subscription.present?
      subscription.canceled_date = Time.at(data['data']['object']['canceled_at'].to_i)
      subscription.is_active = false
      subscription.save!
     end
  end

  def make_inactive(data_event)
    subscription = Subscription.find_by_stripe_customer_token(data['data']['object']['customer'])
    if subscription.present?
      subscription.payment_failed = true
      subscription.stripe_card_token = "stripe_card_token"
      subscription.save!
    end
  end
end

