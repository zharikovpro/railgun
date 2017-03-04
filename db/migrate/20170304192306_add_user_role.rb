class AddUserRole < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE TYPE user_role AS ENUM ('admin', 'support', 'consumer');"
    add_column :users, :role, :user_role, null: false, default: 'consumer', index: true
  end

  def down
    remove_column :users, :role
    execute "DROP TYPE user_role"
  end
end
