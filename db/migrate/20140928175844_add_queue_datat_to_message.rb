class AddQueueDatatToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :transactionId, :string
    add_column :messages, :sourceId, :string
    add_column :messages, :costCenterId, :string
    add_column :messages, :processTypeId, :string
  end
end
