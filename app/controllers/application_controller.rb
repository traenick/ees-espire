class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_model_list

  def get_model_list
    Rails.application.eager_load!
    @all_models = ActiveRecord::Base.descendants.map(&:name)
  end


end
