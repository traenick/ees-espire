class MessageLinksController < ApplicationController
  # GET /message_links
  # GET /message_links.json
  def index
    @message_links = MessageLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @message_links }
    end
  end

  # GET /message_links/1
  # GET /message_links/1.json
  def show
    @message_link = MessageLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message_link }
    end
  end

  # GET /message_links/new
  # GET /message_links/new.json
  def new
    @message_link = MessageLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message_link }
    end
  end

  # GET /message_links/1/edit
  def edit
    @message_link = MessageLink.find(params[:id])
  end

  # POST /message_links
  # POST /message_links.json
  def create
    @message_link = MessageLink.new(params[:message_link])

    respond_to do |format|
      if @message_link.save
        format.html { redirect_to @message_link, notice: 'Message link was successfully created.' }
        format.json { render json: @message_link, status: :created, location: @message_link }
      else
        format.html { render action: "new" }
        format.json { render json: @message_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /message_links/1
  # PUT /message_links/1.json
  def update
    @message_link = MessageLink.find(params[:id])

    respond_to do |format|
      if @message_link.update_attributes(params[:message_link])
        format.html { redirect_to @message_link, notice: 'Message link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_links/1
  # DELETE /message_links/1.json
  def destroy
    @message_link = MessageLink.find(params[:id])
    @message_link.destroy

    respond_to do |format|
      format.html { redirect_to message_links_url }
      format.json { head :no_content }
    end
  end
end
