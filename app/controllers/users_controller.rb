class UsersController < ApplicationController
  before_filter :check_login, :only=>[:edit,:update]
  before_filter :check_admin, :except=>[:edit,:update]
  layout "home"
	
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
	params[:user][:password] = encode( params[:user][:password] )
	params[:user][:level] = 'F'
    @user = User.new(params[:user])
	
	@existing = User.find( :all, :conditions=>["email = ?", params[:user][:email] ] )
	
	if @existing.size > 0
		flash[:notice] = "Someone with that email address is already registered. Please choose another email address, <a href=\"/login\">Login</a> or <a href=\"/users/forgotten\">reset your password</a>." 
		render :action=>"new"
		return false
	end	
	
    if @user.save
    	MailSystem.deliver_new_user( @user )
        flash[:notice] = 'Welcome to hours! To get you started, please create your first client.'
  		session[:user_id] = @user.id        
		redirect_to "/dashboard"
    else
		flash[:notice] = 'Your user details could not be saved, sorry! Please try again'
		redirect_to "/"
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

	if params[:user][:password].blank?
		params[:user][:password] = @user.password
	elsif params[:user][:password] != params[:password_2]
		flash[:notice] = "Your passwords did not match"
		render :action=>"edit"
		return false
	else
		params[:user][:password] = encode( params[:user][:password] )
	end

    if @user.update_attributes(params[:user])
      flash[:notice] = 'Your details were successfully updated.'
      redirect_to "/dashboard"
    else
      flash[:notice] = "Your details could not be updated, sorry! Please try again"
      render :action=>"edit"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
end
