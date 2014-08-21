require 'open-uri'

class WorkspaceController < ApplicationController
  layout 'workspace'


  def index
    @current_user = User.find(params[:user_id] ? params[:user_id] : 1)
    #@messages = @current_user.pending_messages
    @messages = Message.all()
    message_id = @messages.first.id unless @messages.empty?
    @selected_message = Message.find(message_id) if message_id
    @selected_message_hash = JSON.parse(@selected_message.json_string)
    @message_JSON_to_display = @selected_message.json_string
  end

  def load_message
    @selected_message = Message.find(params[:message_id])
    @selected_message_hash = JSON.parse(@selected_message.json_string)
    @message_JSON_to_display = @selected_message.json_string

    respond_to do |format|
      format.js
    end
  end

  def update_selected_message_from_JSON
    @selected_message_hash = JSON.parse(params[:json_string])
    respond_to do |format|
      format.js
    end
  end

  def get_message_JSON_from_URL
    @message_JSON_to_display = JSON(HTTParty.get(params[:json_url]).body).to_json
    respond_to do |format|
      format.js
    end
  end





end
