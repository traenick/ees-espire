class Message < ActiveRecord::Base
  attr_accessible :body, :user_id, :resolved_date, :subject, :message_sub_type_id, :dollar_amt

  belongs_to :message_sub_type
  belongs_to :user
  has_many :message_flows, :order => 'flow_order DESC'
  has_many :message_links

  def json_string
    self.to_json({:methods => [:date_resolved_string, :date_originated_string], :except => [:id, :created_at, :updated_at, :message_sub_type_id],:include => [{:user => {:methods => :full_name, :only => [:first_name, :last_name]}}, {:message_links => {:except => [:id, :created_at, :updated_at]}}, {:message_flows => {:methods => :message_flow_status, :except => [:id, :created_at, :updated_at, :message_id, :response_notes, :response_choice_id, :user_id], :include => {:user => {:methods => :full_name, :only => [:first_name, :last_name]}} }}, {:message_sub_type => {:methods => :type_and_sub_type_name, :except => [:id, :created_at, :updated_at, :message_type_id], :include => {:response_choices => {:except => [:id, :created_at, :updated_at]}}}}]})
  end

  def date_resolved_string
    self.resolved_date.strftime('%D %R') if self.resolved_date
  end

  def date_originated_string
    self.created_at.strftime('%D %R')
  end

  def unused_users
    users_in_flow = self.message_flows.map {|mf| mf.user}
    user_picklist = User.all() - users_in_flow
  end

  def resolved_message_flows_array
    rmfa = self.message_flows.where('date_resolved is not null')
  end


end
