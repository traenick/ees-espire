class AddDeqResponseIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :deq_response_id, :integer
  end
end
