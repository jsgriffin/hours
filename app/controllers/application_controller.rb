# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def check_login( redirect=true )
  	if redirect 
  		if !session[:user_id]
  			redirect_to "/home/login"
  		else
  			return true
  		end
  	else
	  	return session[:user_id]
	end
  end
  
  def get_current_user
  	if check_login
  		@user = User.find( :first, :conditions=>["id = ?", session[:user_id]] )
  		Time.zone = @user.timezone
  	else
  		@user = User.new
  	end
  	return @user
  end
  
  def encode( str )
	return Digest::MD5.hexdigest( str )
  end  
  
end
