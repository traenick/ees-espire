class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json

  before_filter :get_message_sub_types

  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @message.to_json(:include => [:message_links, :message_flows, {:message_sub_type => {:include => :response_choices}}])}
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  def add_link
    @message = Message.find(params[:message_id])
    new_link = @message.message_links.new(display_title:params[:title], url:params[:url])
    if new_link.save
      respond_to do |format|
        format.js
      end
    end
  end

  def add_user_to_flow
    @message = Message.find(params[:message_id])
    new_flow = @message.message_flows.new(message_id:params[:message_id], user_id:params[:user_id], flow_order:@message.message_flows.count+1)
    if new_flow.save
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def get_message_sub_types
    @message_sub_types = MessageSubType.all
  end




end
