class DropEmployees < ActiveRecord::Migration[5.0]
  def change
    drop_table :employees
  end
end
