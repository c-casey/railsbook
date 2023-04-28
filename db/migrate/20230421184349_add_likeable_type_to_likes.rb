class AddLikeableTypeToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :likeable_type, :string
  end
end
