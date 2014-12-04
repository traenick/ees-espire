class AddProcessTypeIdToMessageSubType < ActiveRecord::Migration
  def change
    add_column :message_sub_types, :processTypeId, :string
  end
end
