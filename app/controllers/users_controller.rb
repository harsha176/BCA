class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  skip_before_filter :authorize, :only => [:new, :create]

  def index
    @users = User.all
    for user in @users
          @isAdmin = current_user.admin_rights
          @isDeletable = (user.id == current_user.id) || current_user.admin_rights
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

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  def grant_admin
  @user = User.find(params[:id])
    @user.admin_rights = 'true'
    @user.save
    flash[:notice] = "#{@user.username} has been granted admin privileges"
  #format.html { redirect_to :controller=>:admin, :action=>index }
    redirect_to :controller=>:admin, :action=>:index
end

def revoke_admin
      @user = User.find(params[:id])
    if @user.admin_rights
      @user.admin_rights = nil
    @user.save
    flash[:notice] = "Admin rights have been revoked for #{@user.username}   "
    else
      flash[:notice] = " #{@user.username} is not an admin  "
    end

 # format.html { redirect_to :controller=>:admin, :action=>:index }
  redirect_to :controller=>:admin, :action=>:index
end

end
