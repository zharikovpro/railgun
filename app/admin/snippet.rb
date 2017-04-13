ActiveAdmin.register Snippet do

  permit_params :slug, :text

  form do |f|
    f.inputs 'Snippet' do
      f.input :slug, as: :string
      f.input :text
    end

    f.actions
  end

end
