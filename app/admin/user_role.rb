ActiveAdmin.register UserRole do
  menu priority: 3, label: 'Employees'

  permit_params :grantor_id, :user_id, :role
end