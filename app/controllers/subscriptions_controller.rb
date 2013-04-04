class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!
  
  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = current_user.subscriptions.new
    if @subscription.save_with_payment_on_stripe(current_user, params[:subscription][:stripe_card_token], "1")
      redirect_to projects_path, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end
end
