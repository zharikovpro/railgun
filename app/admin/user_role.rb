ActiveAdmin.register UserRole do
  menu priority: 3, label: 'Employees'
  
  permit_params :grantor_id, :user_id, :role

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs 'Roles' do
      f.div User.find_by_id(params[:user_id]).try(:email)
=begin
      UserRole::TITLES.each do |role|
        if User.find_by_id(params[:user_id]).roles.include? role
        end
      end
=end
      f.input :role, as: :select, collection: UserRole::TITLES
      f.input :user_id, input_html: {value: params[:user_id]}, as: :hidden
    end

    f.actions
  end
end
