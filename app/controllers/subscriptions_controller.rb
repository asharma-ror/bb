class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!
  
  def new
    subscription = current_user.subscriptions.last
    @subscription = subscription.blank? ? Subscription.new(:plan_id => params[:plan_id]) : subscription
  end

  def create
    @subscription = current_user.subscriptions.new
    card_token = params[:subscription][:stripe_card_token]
    plan_id = params[:subscription][:plan_id]
    if @subscription.save_with_payment_on_stripe(current_user, card_token, plan_id)
      redirect_to projects_path, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end
end
