class MessageFlow < ActiveRecord::Base
  attr_accessible :date_received, :date_resolved, :flow_order, :message_id, :response_choice_id, :response_notes, :user_id

  belongs_to :message
  belongs_to :user

  def date_resolved_string
    self.date_resolved if self.date_resolved
    'Pending'
  end

  def message_flow_status
    if !self.date_received.nil? && !self.date_resolved.nil?
      return 'resolved'
    elsif !self.date_received.nil? && self.date_resolved.nil?
      return 'pending'
    else
      return 'default'
    end
  end

end
