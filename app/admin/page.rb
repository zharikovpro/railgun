ActiveAdmin.register Page do
  permit_params do
    active_admin_authorization.retrieve_policy(resource_class).permitted_attributes
  end

  form do |f|
    f.inputs 'Page' do
      f.input :slug
      f.input :markdown
    end

    f.actions
  end
end
