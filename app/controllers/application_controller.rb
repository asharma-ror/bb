class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile
  $now = Time.now.utc

  private
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      return projects_path
    end
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def check_user_plan
    @trail_duration = (current_user.created_at + 30.days)
    if @trail_duration < $now
      flash[:notice] = "Your trail period has beed finished. please take any plan now"
      render :template => "/users/upgrade"
    else
      subscription = current_user.subscriptions.last
      unless subscription.blank?
        plan_days = Plan.find(subscription.plan_id).days
        expire = subscription.created_at + plan_days
        if @trail_duration < $now
          flash[:notice] = "Your current plan has beed expired. please upgrade your plan to continue"
          render :template => "/users/upgrade"
        else
          return true
        end
      else
        return true
      end
    end
  end

end
