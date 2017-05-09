ActiveAdmin.register User do
  menu priority: 2, label: 'Users'

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :user_roles_role_equals, label: 'Role', as: :select, collection: UserRole::TITLES

  scope :employees

  index do
    id_column
    column :email
    actions
  end

  show do
    attributes_table do
      row :email
    end

    active_admin_comments
  end

  permit_params do
    active_admin_authorization.retrieve_policy(resource_class).permitted_attributes
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
