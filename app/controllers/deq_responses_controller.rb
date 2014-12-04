class DeqResponsesController < ApplicationController
  before_action :set_deq_response, only: [:show, :edit, :update, :destroy]

  # GET /deq_responses
  def index
    @deq_responses = DeqResponse.all
  end

  # GET /deq_responses/1
  def show
  end

  # GET /deq_responses/new
  def new
    @deq_response = DeqResponse.new
  end

  # GET /deq_responses/1/edit
  def edit
  end

  # POST /deq_responses
  def create
    @deq_response = DeqResponse.new(deq_response_params)

    if @deq_response.save
      redirect_to @deq_response, notice: 'Deq response was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /deq_responses/1
  def update
    if @deq_response.update(deq_response_params)
      redirect_to @deq_response, notice: 'Deq response was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /deq_responses/1
  def destroy
    @deq_response.destroy
    redirect_to deq_responses_url, notice: 'Deq response was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deq_response
      @deq_response = DeqResponse.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def deq_response_params
      params.require(:deq_response).permit(:response_string, :resolved_at)
    end
end
