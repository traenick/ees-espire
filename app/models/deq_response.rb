# == Schema Information
#
# Table name: deq_responses
#
#  id                      :integer          not null, primary key
#  response_string         :text
#  resolved_at             :datetime
#  created_at              :datetime
#  updated_at              :datetime
#  response_string_as_json :text
#

class DeqResponse < ActiveRecord::Base
end
