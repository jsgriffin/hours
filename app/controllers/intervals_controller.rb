class IntervalsController < ApplicationController
  # GET /intervals
  # GET /intervals.xml
  def index
    @intervals = Interval.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @intervals }
    end
  end

  # GET /intervals/1
  # GET /intervals/1.xml
  def show
    @interval = Interval.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @interval }
    end
  end

  # GET /intervals/new
  # GET /intervals/new.xml
  def new
    @interval = Interval.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @interval }
    end
  end

  # GET /intervals/1/edit
  def edit
    @interval = Interval.find(params[:id])
  end

  # POST /intervals
  # POST /intervals.xml
  def create
  	if params[:client][:id].empty?
  		flash[:notice] = 'Please select a client'
	    redirect_to "/dashboard"
	    return false
  	end
  	
  	@client = Client.find( params[:client][:id] )
  	
  	if params[:int_action] == "start"
	    @interval = @client.intervals.build
		@interval.start = Time.zone.now
	else
		@interval = Interval.find( :first, :conditions => ["client_id = ? AND end IS NULL", @client.id] )
		@interval.end = Time.zone.now
	end
    
	@interval.save
    redirect_to "/dashboard"
  end

  # PUT /intervals/1
  # PUT /intervals/1.xml
  def update
    @interval = Interval.find(params[:id])

    if @interval.update_attributes(params[:interval])
      flash[:notice] = 'Interval was successfully updated.'
    else
      flash[:notice] = "The interval could not be updated, sorry! Please try again"
    end
    
    redirect_to "/dashboard"
  end

  # DELETE /intervals/1
  # DELETE /intervals/1.xml
  def destroy
    @interval = Interval.find(params[:id])
    @interval.destroy

    flash[:notice] = "The interval was deleted successfully."
    redirect_to "/dashboard"
  end
end
