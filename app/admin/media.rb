ActiveAdmin.register Media do
  form do |f|
    f.inputs 'Media' do
      f.input :slug
      f.input :file
    end

    f.actions
  end
end
