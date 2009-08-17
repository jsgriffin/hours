class HomeController < ApplicationController
  
  def index 
  end
  
  def login
  end
  
  def authenticate
  	@user = User.new(params[:userform])
  	valid_user = User.find(:first, :conditions => ["email = ? AND password = ?", @user.email, Digest::MD5.hexdigest( @user.password ) ] )
  	
  	if valid_user
  		session[:user_id] = valid_user.id
  		redirect_to( "/dashboard" )
  	else
  		flash[:notice] = "Invalid login credentials"
  		redirect_to :action => "login"
  	end
  end 
  
  def logout
  	if session[:user_id]
  		reset_session
  		redirect_to :action => "index"
  	end	
  end

  def signup
		@user = User.new
  end	

end
