# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def check_open_interval
  	 @open_interval = Interval.find( :first, :conditions=>["end IS NULL AND client_id IN (SELECT id FROM clients WHERE user_id = ?)", session[:user_id]] )
  	
  	if @open_interval 
  		return Client.find( @open_interval.client_id )
  	else
  		return false
  	end
  end
  
  def get_client_list
  	return Client.find( :all, :conditions=>["user_id = ?", session[:user_id] ] )
  end
  
  def calculate_total_time( client )
    @total = Time.at(0)
    
    for interval in client.intervals
    	if interval.end
	    	@total += (interval.end - interval.start.to_f).to_f
	    end
    end
    
    @total -= 60*60
    return @total
  end
  
  def calculate_total_earnt( client )
  	@total = 0
  	
  	for interval in client.intervals
  		if interval.end
  			@total += (interval.end - interval.start) * (client.rate / (60*60))
  		end
  	end
  	
  	for expense in client.expenses
  		@total += expense.amount
  	end
  	
  	return @total
  end
  
  def time_diff( start, finish )
  	@t = Time.at( finish - start )
  	@t -= 60*60
  	return @t
  end
  
  def time_format
  	return "%H:%M:%S"
  end
   
end
