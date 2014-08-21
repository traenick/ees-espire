class AddDollarAmtToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :dollar_amt, :int
  end
end
