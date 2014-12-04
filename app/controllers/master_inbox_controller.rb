class MasterInboxController < ApplicationController

  def index
    users_with_flows = MessageFlow.select(:user_id).where(date_resolved:nil).uniq
    user_array = []
    users_with_flows.each do |u|
      user_array << u.user_id
    end
    @user_list = User.find(user_array)
  end

end
