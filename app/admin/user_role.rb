ActiveAdmin.register UserRole do
  menu priority: 3, label: 'Roles'

  config.clear_action_items!

  permit_params do
    active_admin_authorization.retrieve_policy(resource_class).permitted_attributes
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs 'Roles' do
      f.div User.find_by_id(params[:user_id]).try(:email)
      f.input :role, as: :select, collection: User.find_by_id(params[:user_id]).missing_roles
      f.input :user_id, input_html: {value: params[:user_id]}, as: :hidden
    end

    f.actions
  end
end
