require 'open-uri'

class WorkspaceController < ApplicationController
  layout 'workspace'


  def index
    @current_user = User.find(params[:user_id] ? params[:user_id] : 1)
    #@messages = @current_user.pending_messages
    @messages = Message.all()
    #@messages_array = JSON.parse(Message.all().to_json)
    @messages_array = []
    @messages.each do |m|
      @messages_array << JSON.parse(m.json_string_digest)
    end
    message_id = @messages_array.first['id'] unless @messages_array.empty?
    @selected_message = Message.find(message_id) if message_id
    @selected_message_hash = JSON.parse(@selected_message.json_string)
    @message_JSON_to_display = @selected_message.json_string
    @digest_JSON_to_display = @messages_array.to_json
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

  def update_message_digest_from_JSON
    @messages_array = JSON.parse(params[:json_string])
    message_id = @messages_array.first['id'] unless @messages_array.empty?
    @selected_message = Message.find(message_id) if message_id
    @selected_message_hash = JSON.parse(@selected_message.json_string)
    respond_to do |format|
      format.js
    end
  end

  def get_digest_JSON_from_URL
    @digest_JSON_to_display = JSON(HTTParty.get(params[:json_url]).body).to_json
    respond_to do |format|
      format.js
    end
  end





end
