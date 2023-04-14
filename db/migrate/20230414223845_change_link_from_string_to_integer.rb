class ChangeLinkFromStringToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :notifications, :link, "integer USING link::integer"
  end
end
