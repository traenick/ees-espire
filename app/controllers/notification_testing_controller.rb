class NotificationTestingController < ApplicationController

  def index
    @current_user = User.find_by_ees_employee_code(params[:ees_employee_code] ? params[:ees_employee_code] : 'thisguy')
    @messages = @current_user.pending_messages
    #@messages = Message.all()
    #@messages_array = JSON.parse(Message.all().to_json)
    @messages_array = []
    @messages.each do |m|
      @messages_array << JSON.parse(m.json_string_digest)
    end
    @digest_JSON_to_display = @messages_array.to_json
  end

  def send_user_digest
    @current_user = User.find(params[:user_id] ? params[:user_id] : 1)
    DigestMailer.daily_digest_mailer(@current_user, params[:json_string], "http://#{request.host}:#{request.port}").deliver
    respond_to do |format|
      format.html {redirect_to :notification_testing}
    end
  end
end
