class AddDeqResponseIdToMessageFlow < ActiveRecord::Migration
  def change
    add_column :message_flows, :deq_response_id, :integer
  end
end
