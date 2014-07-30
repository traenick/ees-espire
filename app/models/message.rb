class Message < ActiveRecord::Base
  attr_accessible :body, :originator_user_id, :resolved_date, :subject, :subtype_id, :type_id
end
