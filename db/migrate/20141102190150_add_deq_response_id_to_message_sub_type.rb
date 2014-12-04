class AddDeqResponseIdToMessageSubType < ActiveRecord::Migration
  def change
    add_column :message_sub_types, :deq_response_id, :integer
  end
end
