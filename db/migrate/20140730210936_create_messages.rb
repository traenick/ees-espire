class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :type_id
      t.integer :subtype_id
      t.string :subject
      t.string :body
      t.integer :originator_user_id
      t.datetime :resolved_date

      t.timestamps
    end
  end
end
