class AddUniqueIndexToLikes < ActiveRecord::Migration[7.0]
  def change
    add_index :likes, [:author_id, :parent_id], unique: true
  end
end
