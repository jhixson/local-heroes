class TopicsController < ApplicationController

  before_filter :require_user, :except => [:index, :show]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @replies = Reply.find_all_by_topic_id(@topic.id)
    @reply = Reply.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic.to_json(:include => :replies) }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # GET /topics/1/reply
  def reply
    @topic = Topic.find(params[:id])
    @topic.replies.build
  end

  # PUT /topics/1/post_reply
  def post_reply
    #@reply = Reply.new(params[:topic][:reply])
    @topic = Topic.find(params[:id])
    @topic.update_attributes(params[:topic])
    render :show
  end

  # POST /topics/1/vote_up
  def vote_up
    @topic = Topic.find(params[:id])
    @current_user.vote_exclusively_for(@topic)
    respond_to do |format|
      format.html { redirect_to @topic }
      format.js { render :nothing => true }
    end
  end

  # POST /topics/1/vote_down
  def vote_down
    @topic = Topic.find(params[:id])
    @current_user.vote_exclusively_against(@topic)
    respond_to do |format|
      format.html { redirect_to @topic }
      format.js { render :nothing => true }
    end
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    @topic.user_id = @current_user.id
    respond_to do |format|
      if @topic.save
        @current_user.vote_exclusively_for(@topic)
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :ok }
    end
  end
end
