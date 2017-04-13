ActiveAdmin.register Snippet do

  permit_params :snippet_ids, :slug, :text

  form do |f|
    f.inputs 'Snippet' do
      f.input :slug, as: :text
      f.input :text
    end
    
    f.actions
  end

end
