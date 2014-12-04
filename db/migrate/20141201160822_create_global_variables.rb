class CreateGlobalVariables < ActiveRecord::Migration
  def change
    create_table :global_variables do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
