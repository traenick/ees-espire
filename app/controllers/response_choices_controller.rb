class ResponseChoicesController < ApplicationController
  # GET /response_choices
  # GET /response_choices.json
  def index
    @response_choices = ResponseChoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @response_choices }
    end
  end

  # GET /response_choices/1
  # GET /response_choices/1.json
  def show
    @response_choice = ResponseChoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @response_choice }
    end
  end

  # GET /response_choices/new
  # GET /response_choices/new.json
  def new
    @response_choice = ResponseChoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @response_choice }
    end
  end

  # GET /response_choices/1/edit
  def edit
    @response_choice = ResponseChoice.find(params[:id])
  end

  # POST /response_choices
  # POST /response_choices.json
  def create
    @response_choice = ResponseChoice.new(params[:response_choice])

    respond_to do |format|
      if @response_choice.save
        format.html { redirect_to @response_choice, notice: 'Response choice was successfully created.' }
        format.json { render json: @response_choice, status: :created, location: @response_choice }
      else
        format.html { render action: "new" }
        format.json { render json: @response_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /response_choices/1
  # PUT /response_choices/1.json
  def update
    @response_choice = ResponseChoice.find(params[:id])

    respond_to do |format|
      if @response_choice.update_attributes(params[:response_choice])
        format.html { redirect_to @response_choice, notice: 'Response choice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @response_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /response_choices/1
  # DELETE /response_choices/1.json
  def destroy
    @response_choice = ResponseChoice.find(params[:id])
    @response_choice.destroy

    respond_to do |format|
      format.html { redirect_to response_choices_url }
      format.json { head :no_content }
    end
  end
end
