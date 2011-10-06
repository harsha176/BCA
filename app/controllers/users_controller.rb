class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  skip_before_filter :authorize, :only => [:new, :create, :show, :index, :search]

  # This method uses
  def index
    @users = User.all
    @isDeletable = Array.new
    for user in @users
          @isAdmin = current_user.admin_rights
          @isDeletable[user.id] = (user.id == current_user.id) || current_user.admin_rights
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
     @isAdmin = current_user.admin_rights
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create

    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = "User #{@user.username} successfully created!"
        format.html { redirect_to @user }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User #{@user.username} successfully updated!"
        format.html { redirect_to @user }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:notice] = "User has been successfully deleted"
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

    def search

    @user_opt = params[:q]
    @users = User.where("username like ?", @user_opt +"%")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

def revoke_admin
      @user = User.find(params[:id])
      #check if the user has admin rights , if yes revoke admin rights
    if @user.admin_rights
      #check if the current user is the same as the user whose admin rights are being revoked.
      #If yes, prohibit the user from revoking admin rights
      if @user.username != current_user.username
        @user.admin_rights = nil
        #save the changes made to the admin_rights column of the user table
        if @user.save(:validate => false)
            flash[:notice] = "Admin rights have been revoked for #{@user.username}   "
        else
              flash[:notice] = "Error revoking admin rights"
        end
      else
        flash[:notice] = "Permission denied! You cannot revoke Admin rights from self"
        end
      else
      flash[:notice] = " #{@user.username} is not an admin  "
    end

 # format.html { redirect_to :controller=>:admin, :action=>:index }
  redirect_to :controller=>:admin, :action=>:index
  end

def grant_admin
    #Grant admin privileges to a user
    # Get the user
    @user = User.find(params[:id])
    #Check if the user is already an admin, If no, grant admin rights.
    if !@user.admin_rights
    @user.admin_rights= 'true'
   if @user.save(:validate => false)
    flash[:notice] = "#{@user.username} has been granted admin privileges"
  else
    flash[:notice] = "Error when granting admin privileges"
  end
    else
      flash[:notice] = "#{@user.username} is already an admin"
    end
  #format.html { redirect_to :controller=>:admin, :action=>index }
    redirect_to :controller=>:admin, :action=>:index
end
end
