class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!
  layout "auction"
  
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

  def express_paypal
    plan = Plan.find(params[:plan])
    response = create_paypal_profile(plan.price*100, plan.projects)
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token) if response.success?
  end

  def complete
    begin
      recurring_profile = EXPRESS_GATEWAY.recurring(params[:amount].to_i, nil, {
        :start_date => Time.now,
        :period => "Month",
        :frequency => 1,
        :auto_bill_outstanding => true,
        :description => "project",
        :token => params[:token]
      })
    unless recurring_profile.success?
      flash[:error] = "Unfortunately an error occurred:" + recurring_profile.message
    else
      Subscription.save_paypal_profile(recurring_profile, params[:project], params[:plan], current_user)
      flash[:notice] = "Thank you for subscribing"
    end  
    rescue Exception => e
        logger.error "Paypal error while creating payment: #{e.message}"
        flash[:error] = e.message
    end
    redirect_to projects_path
  end

  def unsubscribe
    project = current_user.active_projects.find(params[:project])
    subscription = project.subscription
    if !subscription.blank? && subscription.is_active
      paypal_profile_id = subscription.payment_profile_id
      cancel_recurring = EXPRESS_GATEWAY.cancel_recurring(paypal_profile_id) unless paypal_profile_id.blank?
    end
    unless cancel_recurring.success?
      flash[:error] = "Unfortunately an error occurred:" + cancel_recurring.message
    else
      subscription.is_active = false
      subscription.save!
      flash[:notice] = "You successfully canceled the following PayPal Recurring Payment profile. We will no longer bill the buyer."
    end
    redirect_to projects_path
  end

  private

  def create_paypal_profile(amount, quantity)
    EXPRESS_GATEWAY.setup_purchase(amount,
      :ip                => request.remote_ip,
      :return_url        => url_for(:action => 'complete', :project=> params[:project], :plan=>params[:plan], :amount=> amount),
      :cancel_return_url => url_for(:action => 'index', :controller => "projects"),
      :items =>
      [{ :name => "project",
      :quantity => quantity,
      :description => "project",
      :amount => amount
      }],
      :allow_guest_checkout => true,
      :billing_agreement => {
      :type => 'RecurringPayments',
      :description => 'project'
      },
      :initial_amount => amount,
      )
  end
end
