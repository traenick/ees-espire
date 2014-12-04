# == Schema Information
#
# Table name: message_sub_types
#
#  id              :integer          not null, primary key
#  message_type_id :integer
#  sub_type_name   :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  processTypeId   :string(255)
#  deq_response_id :integer
#

class MessageSubType < ActiveRecord::Base

  belongs_to :message_type
  belongs_to :deq_response
  has_many :messages
  has_many :deq_process_types
  has_many :response_choices, -> {order 'display_order'}

  def type_and_sub_type_name
    message_type.name + " | " + self.sub_type_name
  end

  def message_type_name
    message_type.name
  end


end
