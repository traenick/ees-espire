class CreateMessageTypes < ActiveRecord::Migration
  def change
    create_table :message_types do |t|
      t.string :name
      t.string :desc

      t.timestamps
    end
  end
end
