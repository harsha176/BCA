class SessionsController < ApplicationController
  skip_before_filter :authorize
  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sessions }
    end
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
    @session = Session.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @session }
    end
  end

  # GET /sessions/new
  # GET /sessions/new.json
  def new
    @session = Session.new

    render 'sessions/login'
    #respond_to do |format|
    # format.html # new.html.erb
    #format.json { render json: @session }
    # end
  end

  # GET /sessions/1/edit
  def edit
    @session = Session.find(params[:id])
  end

  # POST /sessions
  # POST /sessions.json
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      if !user.admin_rights
        redirect_to posts_url, :notice => "Welcome #{user.username}!"
      else
        redirect_to :controller => :admin, :action=>"index"
       # check for admin_rights
        # redirect to admin
        end
        else
        flash.now.alert = "Login Denied! Invalid username or password"
        render 'sessions/login'
      end
    end

    # PUT /sessions/1
    # PUT /sessions/1.json
    def update
      @session = Session.find(params[:id])

      respond_to do |format|
        if @session.update_attributes(params[:session])
          format.html { redirect_to @session, notice: 'Session was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @session.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /sessions/1
    # DELETE /sessions/1.json
    def destroy
      session[:user_id] = nil
      @curr_user = nil
      redirect_to :log_in, :notice => "Logged out"
    end
    end


