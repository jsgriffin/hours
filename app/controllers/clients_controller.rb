class ClientsController < ApplicationController
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

  def update
    @client = Client.find(params[:id])

    if !@client.update_attributes(params[:client])
      flash[:notice] = 'Client could not be updated.'
    end
    
    redirect_to "/dashboard"
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    flash[:notice] = 'The client has been deleted.'
    redirect_to "/dashboard"
  end
end
