class ChangeParentIdToLikeableId < ActiveRecord::Migration[7.0]
  def change
    rename_column :likes, :parent_id, :likeable_id
  end
end
