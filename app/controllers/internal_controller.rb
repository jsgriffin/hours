class InternalController < ApplicationController
  FREE_CLIENTS_LIMIT = 5
  before_filter :check_login, :only=>[:dashboard]

  def dashboard
  	@user = get_current_user
  	
  	if params[:options]
  		@chosen_clients = []
  		params[:options][:clients].each do |client|
  			if client[1] == 'on'
	  			@chosen_clients.push client[0]
  			end
  		end
  		@clients = Client.find( :all, :conditions=>["user_id = ? AND id IN (#{@chosen_clients.join(',')})", session[:user_id] ], :order=>'name' )
  		
  		@start = Date.civil(params[:options][:"interval_start(1i)"].to_i,
  												params[:options][:"interval_start(2i)"].to_i,
  												params[:options][:"interval_start(3i)"].to_i)
  		@end = Date.civil(params[:options][:"interval_end(1i)"].to_i,
  											params[:options][:"interval_end(2i)"].to_i,
  											params[:options][:"interval_end(3i)"].to_i)
  	else
	  	@clients = Client.find( :all, :conditions=>["user_id = ?", session[:user_id] ], :order=>'name' )
		end

  	@all_clients = Client.find( :all, :conditions=>["user_id = ?", session[:user_id] ], :order=>'name' )

		if @all_clients.size == 0
			@client = Client.new
			render :action=>"first_client"
		end
		
		if @user.level == 'F' && @clients.size == FREE_CLIENTS_LIMIT
			@limit_reached = true
		else
			@limit_reached = false
		end
	
		for i in 0...@clients.length
			@mixed = Array.new

			if !(@start && @end)
				@start = Date.now
				@end = 1.month.ago
			end
			
			@intervals = @clients[i].intervals.find( :all, :conditions=>[ "start >= ? AND end <= ?", @start, @end ] )
			@expenses = @clients[i].expenses.find( :all, :conditions=>[ "created_at >= ? AND created_at <= ?", @start, @end ] )

			for interval in @intervals
				@entry = InvoiceEntry.new
				@entry.is_expense = false
				@entry.interval = interval
				@entry.date = interval.created_at
				@mixed.push( @entry )
			end
			
			for expense in @expenses
				@entry = InvoiceEntry.new
				@entry.is_expense = true
				@entry.expense = expense
				@entry.date = expense.created_at
				@mixed.push( @entry )
			end
			
			@mixed.sort! { |a,b| a.date <=> b.date }	
			@clients[i].combined = @mixed
		end
		
  	@interval = Interval.new
  	
  	@time_format = "%H:%M:%S"
  	@date_format = "%d %B"
  end

  def first_client
  	@client = Client.new
  end
  
  def account
  	@user = get_current_user
  end
  
end

class InvoiceEntry
	attr_accessor :is_expense, :expense, :interval, :date
end