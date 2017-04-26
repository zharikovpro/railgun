ActiveAdmin.register Media do
  permit_params do
    active_admin_authorization.retrieve_policy(resource_class).permitted_attributes
  end

  form do |f|
    f.inputs 'Media' do
      f.input :slug
      f.input :file
    end

    f.actions
  end
end
