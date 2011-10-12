class PostsController < ApplicationController

  # GET /posts
  # GET /posts.json
  skip_before_filter :authorize, :only => [:show, :index, :search]



  # This action is used display all the posts in order defined by a metric. This metric is dependent on vote_cont and creation date.
  def index
    @posts = Post.all
    @votes = Hash.new
    @isDeletable = Array.new
    @isAdmin = current_user.admin_rights
    @notice = params[:notice]
    @user = current_user
    @post_metric_map= Hash.new
    ## create a votes variable and initialize it with vote count and display them index page


    for post in @posts
    @isDeletable[post.id] = (post.user_id == @user.id) || @user.admin_rights
    #here we write our metric by which the posts are sorted.
       @alpha=0.5     # this (0<alpha<1) value determines the importance we give to vote count and created time
                      # e.g. To give high importance to vote count, keep the alpha value low.
       @beta=86400    # this value is used to scale the 'time since creation' . We consider here that
                      # the messages that has been created in one day to be in the same level.
       @votes[post.id] = PostsUsers.get_vote_count(post.id)
       metric = (1-@alpha)*post.vote_count + @alpha*(post.created_at.to_time.to_i() - Time.now().to_i)/@beta
       post.metric=metric
      post.save
    end

    @posts = Post.find(:all, :order => 'metric' ).reverse
   # @post_metric_map.sort_by {|id, metric| metric}
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end


  # GET /posts/new
  # GET /posts/new.json
  def new
    authorize
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    authorize
    @post = Post.find(params[:id])
    @user = current_user
    @post_user_id = @post.user_id
  end

  # POST /posts
  # POST /posts.json
  def create
    authorize
    @user = current_user
    @post = Post.new(params[:post])
    @post.user_id = @user.id

    respond_to do |format|
      if @post.save
        flash[:notice] =  'Post was successfully created.'
        format.html { redirect_to @post}
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    authorize
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    authorize            # before destroying any user it has to be authorized.
    @post = Post.find(params[:id])
    @user = current_user

    @post.destroy
         respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
      end
  end

  #
  # Updates votes when ever a user casts votes.
  #
  def update_votes
    @user = current_user
    @post_id = params[:post_id]
    post=Post.find(@post_id)

    post.save

    msg = PostsUsers.vote(@user.id, @post_id)

    redirect_to :action => "index", :notice => msg

  end

  #
  #
  # This action searches for all the posts either posted by given user or by post title.
  #
  def search
     @user_opt = params[:user_opt]
     @key = params[:q]
     @votes = Hash.new
     @msg = ""
     @isDeletable = Array.new
     @posts = Array.new
     @user = current_user

     if @user_opt.to_i == 1
       @posts = Post.where("title like ? or message like ?", "%" + params[:q] +"%","%"+ params[:q] + "%")
       ## create a votes variable and initialize it with vote count and display them index page
     else
           @posts = Post.find_all_by_user_id(User.find_by_username(params[:q]).id)
     end

     for post in @posts
             @votes[post.id] = PostsUsers.get_vote_count(post.id)
     end

     # Checking which of the posts user can delete
     for post in @posts
       @isDeletable[post.id] = (post.user_id == @user.id) || @user.admin_rights
     end

     if @posts.empty?
         @msg = "No search results found. Try new search"
     end
     respond_to do |format|
         format.html # show.html.erb
         format.json { render json: @post }
     end

   end


end