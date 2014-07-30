class MessageFlow < ActiveRecord::Base
  attr_accessible :date_received, :date_resolved, :flow_order, :message_id, :response_choice_id, :response_notes, :user_id
end
