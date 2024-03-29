class RepliesController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all

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
  def new
    @reply = Reply.new

    respond_to do |format|
      format.html # new.html.erb
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
    @reply = Reply.new(params[:reply])
    @reply.user_id = @current_user.id
    @topic = Topic.find @reply.topic_id

    respond_to do |format|
      if @reply.save
        format.html { redirect_to @topic, notice: 'Reply was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
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

  # POST /replies/1/vote_up
  def vote_up
    @reply = Reply.find(params[:id])
    @current_user.vote_exclusively_for(@reply)
    respond_to do |format|
      format.html { redirect_to @reply }
      format.js { render :nothing => true }
    end
  end

  # POST /replies/1/vote_down
  def vote_down
    @reply = Reply.find(params[:id])
    @current_user.vote_exclusively_against(@reply)
    respond_to do |format|
      format.html { redirect_to @reply }
      format.js { render :nothing => true }
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
end
