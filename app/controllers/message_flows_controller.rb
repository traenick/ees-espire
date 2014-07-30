class MessageFlowsController < ApplicationController
  # GET /message_flows
  # GET /message_flows.json
  def index
    @message_flows = MessageFlow.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @message_flows }
    end
  end

  # GET /message_flows/1
  # GET /message_flows/1.json
  def show
    @message_flow = MessageFlow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message_flow }
    end
  end

  # GET /message_flows/new
  # GET /message_flows/new.json
  def new
    @message_flow = MessageFlow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message_flow }
    end
  end

  # GET /message_flows/1/edit
  def edit
    @message_flow = MessageFlow.find(params[:id])
  end

  # POST /message_flows
  # POST /message_flows.json
  def create
    @message_flow = MessageFlow.new(params[:message_flow])

    respond_to do |format|
      if @message_flow.save
        format.html { redirect_to @message_flow, notice: 'Message flow was successfully created.' }
        format.json { render json: @message_flow, status: :created, location: @message_flow }
      else
        format.html { render action: "new" }
        format.json { render json: @message_flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /message_flows/1
  # PUT /message_flows/1.json
  def update
    @message_flow = MessageFlow.find(params[:id])

    respond_to do |format|
      if @message_flow.update_attributes(params[:message_flow])
        format.html { redirect_to @message_flow, notice: 'Message flow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message_flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_flows/1
  # DELETE /message_flows/1.json
  def destroy
    @message_flow = MessageFlow.find(params[:id])
    @message_flow.destroy

    respond_to do |format|
      format.html { redirect_to message_flows_url }
      format.json { head :no_content }
    end
  end
end
