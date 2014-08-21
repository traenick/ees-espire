class User < ActiveRecord::Base
  attr_accessible :api_token, :email_address, :first_name, :last_name

  has_many :message_flows

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def pending_messages
    message_id_array = MessageFlow.where("user_id = #{self.id} AND date_received is not NULL AND date_resolved is NULL").map {|x| x.message_id}.to_a
    message_digest = Message.find(message_id_array)
  end

end
