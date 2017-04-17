ActiveAdmin.register UserRole do
  menu priority: 3, label: 'Employees'
  config.clear_action_items!
  permit_params :grantor_id, :user_id, :role

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs 'Roles' do
      f.div User.find_by_id(params[:user_id]).try(:email)
      f.input :role, as: :select, collection: User.find_by_id(params[:user_id]).available_roles(params[:user_id])
      f.input :user_id, input_html: {value: params[:user_id]}, as: :hidden
    end

    f.actions
  end
end
