class MessageLink < ActiveRecord::Base
  attr_accessible :display_title, :message_id, :url

  belongs_to :message

end
