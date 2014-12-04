# == Schema Information
#
# Table name: message_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  desc       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MessageType < ActiveRecord::Base

  has_many :message_sub_types

end
