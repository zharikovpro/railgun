ActiveAdmin.register Snippet do
  permit_params do
    active_admin_authorization.retrieve_policy(resource_class).permitted_attributes
  end

  form do |f|
    f.inputs 'Snippet' do
      f.input :slug
      f.input :text
    end

    f.actions
  end
end
