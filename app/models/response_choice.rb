class ResponseChoice < ActiveRecord::Base
  attr_accessible :api_string, :button_style, :button_title, :display_order, :note_required, :message_sub_type_id

  belongs_to :message_sub_type

end
