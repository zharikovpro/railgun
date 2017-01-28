class RenameAdminUsersToEmployees < ActiveRecord::Migration[5.0]
  def change
    rename_table :admin_users, :employees
  end
end
