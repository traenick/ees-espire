class CreateMessageSubTypes < ActiveRecord::Migration
  def change
    create_table :message_sub_types do |t|
      t.integer :message_type_id
      t.string :sub_type_name

      t.timestamps
    end
  end
end
