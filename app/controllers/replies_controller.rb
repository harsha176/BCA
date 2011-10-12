class RepliesController < ApplicationController
  # GET /replies
  # GET /replies.json

  # This action list all the replies along with its posts.
  def index
    @replies = Reply.all
    @votes = Hash.new
    @notice = params[:notice]

    for reply in @replies
      @votes[reply.id] = RepliesUsers.get_vote_count(reply.id)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @replies }
    end
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
    @reply = Reply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reply }
    end
  end

  # GET /replies/new
  # GET /replies/new.json
  # lists all the replies for given post.
  def new
    @reply = Reply.new
    @reply.post_id = params[:post_id]
    @replies = Reply.find_all_by_post_id(@reply.post_id)

    respond_to do |format|
      format.html  # new.html.erb
      format.json { render json: @reply }
    end
  end

  # GET /replies/1/edit
  def edit
    @reply = Reply.find(params[:id])
  end

  # POST /replies
  # POST /replies.json
  def create
    authorize
    @reply = Reply.new(params[:reply])
    @reply.user_id = current_user.id

    respond_to do |format|
      if @reply.save
        format.html { redirect_to @reply, notice: 'Reply was successfully created.' }
        format.json { render json: @reply, status: :created, location: @reply }
      else
        format.html { render action: "new" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /replies/1
  # PUT /replies/1.json
  def update
    @reply = Reply.find(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to replies_url }
      format.json { head :ok }
    end
  end

  def update_votes
    @user = current_user
    @reply_id = params[:reply_id]

    msg = RepliesUsers.vote(@user.id, @reply_id)

    redirect_to :action => "index", :notice => msg

  end
end
