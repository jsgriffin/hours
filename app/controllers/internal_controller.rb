class InternalController < ApplicationController

  before_filter :check_login, :only=>[:dashboard]

  def dashboard
  	@user = get_current_user
  	@clients = Client.find( :all, :conditions=>["user_id = ?", session[:user_id] ] )

	if @clients.size == 0
		@client = Client.new
		render :action=>"first_client"
	end

  	@interval = Interval.new
  	
  	@time_format = "%H:%M:%S"
  	@date_format = "%d %B"
  end

  def first_client
  	@client = Client.new
  end
  
end