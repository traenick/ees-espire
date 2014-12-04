# == Schema Information
#
# Table name: response_choices
#
#  id                  :integer          not null, primary key
#  message_sub_type_id :integer
#  display_order       :integer
#  button_title        :string(255)
#  button_style        :string(255)
#  api_string          :string(255)
#  note_required       :boolean
#  created_at          :datetime
#  updated_at          :datetime
#

class ResponseChoice < ActiveRecord::Base

  belongs_to :message_sub_type

end
