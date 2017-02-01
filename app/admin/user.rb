ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :email
    column :sign_in_count
    column :created_at
    actions
  end

  action_item only: :show do
    if policy(:reincarnation).create?
      link_to 'Reincarnate', user_reincarnation_path(resource.id), method: :post
    end
  end
end
