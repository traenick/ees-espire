class MessageFlow < ActiveRecord::Base
  attr_accessible :date_received, :date_resolved, :flow_order, :message_id, :response_choice_id, :response_notes, :user_id

  belongs_to :message
  belongs_to :user

  def date_resolved_string
    self.date_resolved if self.date_resolved
    'Pending'
  end

end
