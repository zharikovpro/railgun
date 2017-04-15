ActiveAdmin.register UserRole do
  menu priority: 3, label: 'Employees'

  permit_params :grantor_id, :user_id, :role

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs 'Roles' do
      f.input :role, as: :select, collection: UserRole::TITLES
    end

    f.actions
  end
end
