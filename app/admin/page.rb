ActiveAdmin.register Page do
  form do |f|
    f.inputs 'Page' do
      f.input :slug
      f.input :markdown
    end

    f.actions
  end
end
