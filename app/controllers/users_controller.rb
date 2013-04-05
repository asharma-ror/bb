class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_user_plan
  
  def upgrade
  end
  
  def cancel_user_plan
    subscription = current_user.subscriptions.last
    begin
      customer = Stripe::Customer.retrieve(subscription.stripe_customer_token)
      customer.delete
      subscription.is_active = false
      subscription.save!
      redirect_to projects_path, :flash => {:notice => "Plan has been successfully deleted"}
    rescue
      redirect_to projects_path, :flash => {:notice => "Error occured during process"}
    end
  end
end
