class MessageSubType < ActiveRecord::Base
  attr_accessible :sub_type_name, :message_type_id

  belongs_to :message_type
  has_many :messages
  has_many :response_choices, :order => :display_order

  def type_and_sub_type_name
    message_type.name + " | " + self.sub_type_name
  end

  def message_type_name
    message_type.name
  end


end
