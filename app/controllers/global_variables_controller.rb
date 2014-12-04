class GlobalVariablesController < ApplicationController
  before_action :set_global_variable, only: [:show, :edit, :update, :destroy]

  # GET /global_variables
  def index
    @global_variables = GlobalVariable.all
  end

  # GET /global_variables/1
  def show
  end

  # GET /global_variables/new
  def new
    @global_variable = GlobalVariable.new
  end

  # GET /global_variables/1/edit
  def edit
  end

  # POST /global_variables
  def create
    @global_variable = GlobalVariable.new(global_variable_params)

    if @global_variable.save
      redirect_to @global_variable, notice: 'Global variable was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /global_variables/1
  def update
    if @global_variable.update(global_variable_params)
      redirect_to @global_variable, notice: 'Global variable was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /global_variables/1
  def destroy
    @global_variable.destroy
    redirect_to global_variables_url, notice: 'Global variable was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_global_variable
      @global_variable = GlobalVariable.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def global_variable_params
      params.require(:global_variable).permit(:key, :value)
    end
end
