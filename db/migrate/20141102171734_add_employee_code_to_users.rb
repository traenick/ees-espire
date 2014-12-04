class AddEmployeeCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ees_employee_code, :string
  end
end
