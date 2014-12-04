# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  first_name        :string(255)
#  last_name         :string(255)
#  email_address     :string(255)
#  api_token         :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  ees_employee_code :string(255)
#  deq_response_id   :integer
#

class User < ActiveRecord::Base

  belongs_to :deq_response
  has_many :message_flows

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def pending_messages
    message_id_array = MessageFlow.where("user_id = #{self.id} AND date_resolved is NULL").map {|x| x.message_id}.to_a
    message_digest = Message.find(message_id_array)
  end

  def pending_message_flows
    message_id_array = MessageFlow.where("user_id = #{self.id} AND date_resolved is NULL")
  end

  def user_digest_json_string
    pending_messages.each do |m|
      @messages_array << JSON.parse(m.json_string_digest)
    end
  end


end
