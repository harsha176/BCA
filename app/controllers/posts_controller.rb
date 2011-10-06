class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.paginate(:page=>params[:page],:per_page=>10)
    @posts = Post.all()
    @votes = Hash.new
    @user = current_user
    @post_metric_map= Hash.new

    ## create a votes variable and initialize it with vote count and display them index page


    for post in @posts
       @alpha=0.6
       @isDeletable = (User.find(post.user_id).id == @user.id) || @user.admin_rights
       @votes[post.id] = PostsUsers.get_vote_count(post.id)
       metric = (1-@alpha)*post.vote_count + @alpha*(post.created_at.to_time.to_i() - Time.now().to_i)/600
       @post_metric_map[post.id] = metric
    end

    @posts = Hash.new
    @post_metric_map.sort_by {|id, metric| metric}
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
      format.html { redirect_to posts_path }
        format.json { head :ok }
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
    authorize
    @post = Post.find(params[:id])
    @user = current_user

    @post.destroy
         respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
      end
  end

  def update_votes
    @user = current_user
    @post_id = params[:post_id]
    post=Post.find(@post_id)
    post.vote_count=post.vote_count+1
    post.save

    msg = PostsUsers.vote(@user.id, @post_id)

    redirect_to :action => "index"

  end

  def search

       respond_to do |format|
      format.html
      format.xml { render :xml => @post }
    end
  end
end
