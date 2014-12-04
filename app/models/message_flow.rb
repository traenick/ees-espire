# == Schema Information
#
# Table name: message_flows
#
#  id                 :integer          not null, primary key
#  message_id         :integer
#  flow_order         :integer
#  user_id            :integer
#  date_received      :datetime
#  date_resolved      :datetime
#  response_choice_id :integer
#  response_notes     :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  deq_response_id    :integer
#

class MessageFlow < ActiveRecord::Base

  belongs_to :message
  belongs_to :user
  belongs_to :deq_response

  def json_string
    self.to_json({:methods => [:date_resolved_string, :message_flow_status],:include => [{:user => {:methods => :full_name, :only => [:first_name, :last_name]}}, {:message_links => {:except => [:id, :created_at, :updated_at]}}, {:message_flows => {:methods => :message_flow_status, :except => [:id, :updated_at, :message_id, :response_notes, :response_choice_id, :user_id], :include => {:user => {:methods => :full_name, :only => [:first_name, :last_name]}} }}, {:message_sub_type => {:methods => [:type_and_sub_type_name, :message_type_name], :only => [:sub_type_name], :include => {:response_choices => {:except => [:id, :created_at, :updated_at]}}}}]})
  end

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
