class Message < ActiveRecord::Base
  attr_accessible :body, :user_id, :resolved_date, :subject, :message_sub_type_id

  belongs_to :message_sub_type
  belongs_to :user
  has_many :message_flows, :order => 'flow_order DESC'
  has_many :message_links

  def date_resolved_string
    self.resolved_date if self.resolved_date
    'Not resolved'
  end

  def unused_users
    user_picklist = User.all()
  end

end
