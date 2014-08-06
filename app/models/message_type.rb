class MessageType < ActiveRecord::Base
  attr_accessible :desc, :name

  has_many :message_sub_types

end
