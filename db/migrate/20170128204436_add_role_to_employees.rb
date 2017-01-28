class AddRoleToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :role, :integer, null: false
  end
end
