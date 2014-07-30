class CreateMessageSubTypes < ActiveRecord::Migration
  def change
    create_table :message_sub_types do |t|
      t.integer :type_id
      t.string :subtype_name

      t.timestamps
    end
  end
end
