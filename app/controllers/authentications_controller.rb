class AuthenticationsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]    
    authentication = Authentication.find_from_hash(auth)
    existed_email = AuctionAdmin.find_by_email(auth['info']['email'])    
    if authentication
      # Authentication found, sign the au in.
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:auction_admin, authentication.auction_admin)      
    elsif existed_email
      flash[:notice] = "Already you registered with this email.So, please try with another."
      redirect_to root_url
    else
      # Authentication not found, thus a new user.
      auction_admin = AuctionAdmin.new
      auction_admin.apply_omniauth(auth)
      auction_admin.skip_confirmation!
      if auction_admin.save(:validate => false)
        flash[:notice] = "Account created and signed in successfully."
        sign_in_and_redirect(:auction_admin, auction_admin)
      else
        flash[:error] = "Error while creating account. Please try again."
        redirect_to root_url
      end
    end
  end

  def destroy
    session[:auction_admin_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def facebook_logout
    split_token = session[:fb_token].split("|")
    fb_api_key = split_token[0]
    fb_session_key = split_token[1]
    redirect_to "http://www.facebook.com/logout.php?api_key=#{fb_api_key}&session_key=#{fb_session_key}&confirm=1&next=#{destroy_user_session_url}";
  end

  def failure
    #flash[:error] = "You are on back."
    redirect_to root_url
  end

end
