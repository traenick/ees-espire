class MessageTypesController < ApplicationController
  # GET /message_types
  # GET /message_types.json
  def index
    @message_types = MessageType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @message_types }
    end
  end

  # GET /message_types/1
  # GET /message_types/1.json
  def show
    @message_type = MessageType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message_type }
    end
  end

  # GET /message_types/new
  # GET /message_types/new.json
  def new
    @message_type = MessageType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message_type }
    end
  end

  # GET /message_types/1/edit
  def edit
    @message_type = MessageType.find(params[:id])
  end

  # POST /message_types
  # POST /message_types.json
  def create
    @message_type = MessageType.new(params[:message_type])

    respond_to do |format|
      if @message_type.save
        format.html { redirect_to @message_type, notice: 'Message type was successfully created.' }
        format.json { render json: @message_type, status: :created, location: @message_type }
      else
        format.html { render action: "new" }
        format.json { render json: @message_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /message_types/1
  # PUT /message_types/1.json
  def update
    @message_type = MessageType.find(params[:id])

    respond_to do |format|
      if @message_type.update_attributes(params[:message_type])
        format.html { redirect_to @message_type, notice: 'Message type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_types/1
  # DELETE /message_types/1.json
  def destroy
    @message_type = MessageType.find(params[:id])
    @message_type.destroy

    respond_to do |format|
      format.html { redirect_to message_types_url }
      format.json { head :no_content }
    end
  end
end
