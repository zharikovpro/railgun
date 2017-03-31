ActiveAdmin.register User do
  menu priority: 2, label: 'Users'

  permit_params :email, :password, :password_confirmation,
                user_role_ids: [],
                user_roles_attributes: [
                  :id,
                  :grantor_id, :user_id, :role,
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
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    columns do
      column do
        attributes_table do
          row :email
        end
      end

      column do
        panel 'Roles' do
          table_for user.user_roles do
            column(:role) { |user_role| user_role.role.titleize }
          end
        end
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

    f.inputs 'Roles' do
      f.has_many :user_roles, new_record: 'Add Role', allow_destroy: true do |r|
        r.input :grantor_id, as: :hidden, input_html: { value: current_user.id }
        r.input :role, as: :select, collection: UserRole::TITLES
      end
    end

    f.actions
  end
end
