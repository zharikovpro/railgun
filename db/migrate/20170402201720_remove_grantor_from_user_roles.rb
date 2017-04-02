class RemoveGrantorFromUserRoles < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_roles, :grantor_id
  end
end
