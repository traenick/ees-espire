class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :type_id
      t.integer :message_sub_type_id
      t.string :subject
      t.string :body
      t.integer :user_id
      t.datetime :resolved_date

      t.timestamps
    end
  end
end
