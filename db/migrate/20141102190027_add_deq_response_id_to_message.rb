class AddDeqResponseIdToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :deq_response_id, :integer
  end
end
