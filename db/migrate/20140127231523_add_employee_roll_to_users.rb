class AddEmployeeRollToUsers < ActiveRecord::Migration
  def change
    add_column :users, :employee_roll, :string
  end
end
