class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile
  $now = Time.now.utc

  before_filter :authenticate_user!, :set_locale

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  protected
  def render_404
    respond_to do |format|
      format.html do
        render :file => Rails.root.join('public', '404.html'),
          :status => '404'
      end
      format.xml do
        render :nothing => true, :status => '404'
      end
    end
  end

  private

  def set_locale
    if !current_user.nil? && !current_user.locale.nil? && !current_user.locale.empty?
      I18n.locale = current_user.locale.to_sym 
    else
      I18n.locale = :en
    end
  end
  
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
    trail_duration = (current_user.created_at + 15.days)
    subscription = current_user.subscriptions
    if !subscription.blank?
      sub = subscription.last
      if sub.is_active == true
        return true
      else
        return true
        flash[:notice] = "Your subscription has beed deactivated. please take a plan now"
        render :template => "/users/upgrade"
      end
    else
      if trail_duration < $now
        return true
        flash[:notice] = "Your trail period has beed finished. please take a plan now"
        render :template => "/users/upgrade"
      else
        return true
      end
    end
  end

end
