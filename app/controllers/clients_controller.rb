class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.xml
  def index
    @clients = Client.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.xml
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.xml
  def new
    @client = Client.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end   
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.xml
  def create
    #@client = Client.new(params[:client])

    #respond_to do |format|
    #  if @client.save
    #    flash[:notice] = 'Client was successfully created.'
    #    format.html { redirect_to(@client) }
    #    format.xml  { render :xml => @client, :status => :created, :location => @client }
    #  else
    #    format.html { render :action => "new" }
    #    format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
    #  end
    #end
        
    @user = get_current_user
    @client = @user.clients.build( params[:client] )
    
    if @client.save 
    	redirect_to( "/dashboard" )
    else
    	render :action=>"new"
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])

    if !@client.update_attributes(params[:client])
      flash[:notice] = 'Client could not be updated.'
    end
    
    redirect_to "/dashboard"
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    flash[:notice] = 'The client has been deleted.'
    redirect_to "/dashboard"
  end
end
