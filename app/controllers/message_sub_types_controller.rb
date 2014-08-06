class MessageSubTypesController < ApplicationController
  # GET /message_sub_types
  # GET /message_sub_types.json

  before_filter :get_message_types

  def index
    @message_sub_types = MessageSubType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @message_sub_types }
    end
  end

  # GET /message_sub_types/1
  # GET /message_sub_types/1.json
  def show
    @message_sub_type = MessageSubType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message_sub_type }
    end
  end

  # GET /message_sub_types/new
  # GET /message_sub_types/new.json
  def new
    @message_sub_type = MessageSubType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message_sub_type }
    end
  end

  # GET /message_sub_types/1/edit
  def edit
    @message_sub_type = MessageSubType.find(params[:id])
  end

  # POST /message_sub_types
  # POST /message_sub_types.json
  def create
    @message_sub_type = MessageSubType.new(params[:message_sub_type])

    respond_to do |format|
      if @message_sub_type.save
        format.html { redirect_to @message_sub_type, notice: 'Message sub type was successfully created.' }
        format.json { render json: @message_sub_type, status: :created, location: @message_sub_type }
      else
        format.html { render action: "new" }
        format.json { render json: @message_sub_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /message_sub_types/1
  # PUT /message_sub_types/1.json
  def update
    @message_sub_type = MessageSubType.find(params[:id])

    respond_to do |format|
      if @message_sub_type.update_attributes(params[:message_sub_type])
        format.html { redirect_to @message_sub_type, notice: 'Message sub type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message_sub_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_sub_types/1
  # DELETE /message_sub_types/1.json
  def destroy
    @message_sub_type = MessageSubType.find(params[:id])
    @message_sub_type.destroy

    respond_to do |format|
      format.html { redirect_to message_sub_types_url }
      format.json { head :no_content }
    end
  end

  def add_response_choice
    @message_sub_type = MessageSubType.find(params[:message_sub_type_id])
    new_response = @message_sub_type.response_choices.new(button_title:params[:button_title], button_style:params[:button_style], display_order:params[:display_order], api_string:params[:api_string], note_required:params[:note_required])
    if new_response.save
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def get_message_types
    @message_types = MessageType.all
  end


end
