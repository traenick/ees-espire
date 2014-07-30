class CreateMessageLinks < ActiveRecord::Migration
  def change
    create_table :message_links do |t|
      t.integer :message_id
      t.string :display_title
      t.string :url

      t.timestamps
    end
  end
end
