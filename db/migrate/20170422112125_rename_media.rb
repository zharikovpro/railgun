class RenameMedia < ActiveRecord::Migration[5.0]
  def change
    rename_table :media, :medias
  end
end
