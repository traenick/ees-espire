class ResponseChoice < ActiveRecord::Base
  attr_accessible :api_string, :button_style, :button_title, :display_order, :note_required, :subtype_id
end
