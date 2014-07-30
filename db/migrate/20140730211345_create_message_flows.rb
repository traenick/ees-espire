class CreateMessageFlows < ActiveRecord::Migration
  def change
    create_table :message_flows do |t|
      t.integer :message_id
      t.integer :flow_order
      t.integer :user_id
      t.datetime :date_received
      t.datetime :date_resolved
      t.integer :response_choice_id
      t.string :response_notes

      t.timestamps
    end
  end
end
