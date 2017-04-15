ActiveAdmin.register User do
  menu priority: 2, label: 'Users'

  permit_params :email, :password, :password_confirmation,
                user_role_ids: [],
                user_roles_attributes: [
                  :id,
                  :user_id, :role,
                  :_create, :_destroy
                ]

  controller do
    def update
      # allow updates without password change
      if params[:user][:password].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end

      super
    end
  end

  index do
    selectable_column
    column :id
    column :email
    actions do |post|
      item "Add Role", new_staff_user_role_path(id: id)
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :user_roles_role_equals, label: "Role", as: :select, collection: UserRole::TITLES

  scope :employees

  show do
    attributes_table do
      row :roles do
        user.user_roles.map(&:role).join(', ')
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
end
