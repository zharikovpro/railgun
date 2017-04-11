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

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  
=begin  
  index do
    id_column
    column :email
    column :user_role_ids
    column :user_roles
    actions
  end
=end

  scope :employees

  form do |f|
    f.inputs 'Credentials' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.inputs 'Roles' do
      f.has_many :user_roles, new_record: 'Add Role', allow_destroy: true do |r|
        r.input :role, as: :select, collection: UserRole::TITLES
      end
    end

    f.actions
  end

end
