ActiveAdmin.register UserRole do
  menu priority: 3, label: 'Employees'

  permit_params :user_id, :role
end
