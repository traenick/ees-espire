class CreateResponseChoices < ActiveRecord::Migration
  def change
    create_table :response_choices do |t|
      t.integer :subtype_id
      t.integer :display_order
      t.string :button_title
      t.string :button_style
      t.string :api_string
      t.boolean :note_required

      t.timestamps
    end
  end
end
