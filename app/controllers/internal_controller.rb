class InternalController < ApplicationController
  FREE_CLIENTS_LIMIT = 5
  before_filter :check_login, :only=>[:dashboard]

  def dashboard
  	@user = get_current_user
  	@clients = Client.find( :all, :conditions=>["user_id = ?", session[:user_id] ], :order=>'name' )

	if @clients.size == 0
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
		
		for interval in @clients[i].intervals
			@entry = InvoiceEntry.new
			@entry.is_expense = false
			@entry.interval = interval
			@entry.date = interval.created_at
			@mixed.push( @entry )
		end
		
		for expense in @clients[i].expenses
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