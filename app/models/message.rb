# == Schema Information
#
# Table name: messages
#
#  id                  :integer          not null, primary key
#  type_id             :integer
#  message_sub_type_id :integer
#  subject             :string(255)
#  body                :string(255)
#  user_id             :integer
#  resolved_date       :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  dollar_amt          :integer
#  q_transaction_id    :string(255)
#  q_source_id         :string(255)
#  q_cost_center_id    :string(255)
#  q_process_type_id   :string(255)
#  deq_response_id     :integer
#

class Message < ActiveRecord::Base

  belongs_to :message_sub_type
  belongs_to :user
  belongs_to :deq_response
  has_many :message_flows, -> { order 'flow_order desc' }
  has_many :message_links

  def json_string
    self.to_json({:methods => [:date_resolved_string, :date_originated_string, :dollar_amt_float],:include => [{:user => {:methods => :full_name, :only => [:first_name, :last_name]}}, {:message_links => {:except => [:id, :created_at, :updated_at]}}, {:message_flows => {:methods => :message_flow_status, :except => [:id, :updated_at, :message_id, :response_notes, :response_choice_id, :user_id], :include => {:user => {:methods => :full_name, :only => [:first_name, :last_name]}} }}, {:message_sub_type => {:methods => [:type_and_sub_type_name, :message_type_name], :only => [:sub_type_name], :include => {:response_choices => {:except => [:id, :created_at, :updated_at]}}}}]})
  end

  def json_string_digest
    self.to_json({:methods => [:date_resolved_string, :date_originated_string, :dollar_amt_float], :only => [:id, :subject, :created_at],:include => [{:user => {:methods => :full_name, :only => [:first_name, :last_name]}}, {:message_sub_type => {:methods => :message_type_name, :only => [:sub_type_name]}}]})
  end

  def date_resolved_string
    self.resolved_date.strftime('%D %R') if self.resolved_date
  end

  def date_originated_string
    self.created_at.strftime('%D %R')
  end

  def dollar_amt_float
    Float(self.dollar_amt.to_i*0.01)
  end

  def unused_users
    users_in_flow = self.message_flows.map {|mf| mf.user}
    user_picklist = User.all() - users_in_flow
  end

  def resolved_message_flows_array
    rmfa = self.message_flows.where('date_resolved is not null')
  end

  def message_flow_for_user(user_id)
    self.message_flows.where(user_id:user_id).first
  end


end
