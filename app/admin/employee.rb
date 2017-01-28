ActiveAdmin.register Employee do
  permit_params :role, :email, :password, :password_confirmation

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
    attributes_table do
      row :role
      row :email
    end

    active_admin_comments
  end

  form do |f|
    f.inputs 'Admin Details' do
      f.input :role
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
