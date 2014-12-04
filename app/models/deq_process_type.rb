# == Schema Information
#
# Table name: deq_process_types
#
#  id                        :integer          not null, primary key
#  processTypeId             :string(255)      not null
#  message_sub_type_id       :integer          not null
#  originating_transactionId :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  deq_response_id           :integer
#

class DeqProcessType < ActiveRecord::Base
  belongs_to :message_sub_type
end
