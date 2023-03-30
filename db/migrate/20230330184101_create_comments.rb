class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :parent, null: false, foreign_key: { to_table: :posts }

      t.timestamps
    end
  end
end
