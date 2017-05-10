ActiveAdmin.register Snippet do
  form do |f|
    f.inputs 'Snippet' do
      f.input :slug
      f.input :text
    end

    f.actions
  end
end
