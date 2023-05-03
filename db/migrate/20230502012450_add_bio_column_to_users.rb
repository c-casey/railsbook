class AddBioColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bio, :string, limit: 150
  end
end
