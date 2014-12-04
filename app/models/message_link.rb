# == Schema Information
#
# Table name: message_links
#
#  id            :integer          not null, primary key
#  message_id    :integer
#  display_title :string(255)
#  url           :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class MessageLink < ActiveRecord::Base

  belongs_to :message

end
