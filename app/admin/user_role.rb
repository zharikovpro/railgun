ActiveAdmin.register UserRole do
  menu priority: 3, label: 'Employees'

  permit_params :grantor_id, :user_id, :role

  index do
    selectable_column
    id_column
    column :user
    column :role
    column :created_at
    actions
  end
end
