ActiveAdmin.register User do
  menu priority: 2, label: 'Users'

  permit_params :email, :password, :password_confirmation,
                user_role_ids: [],
                user_roles_attributes: [
                  :id,
                  :user_id, :role,
                  :_create, :_destroy
                ]

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :user_roles_role_equals, label: 'Role', as: :select, collection: UserRole::TITLES

  scope :employees

  show do
    attributes_table do
      row :roles do
        user.roles.join(', ')
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Credentials' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end

  action_item only: :edit  do
    link_to 'Add Role', new_staff_user_role_path(user_id: user.id)
  end
end
