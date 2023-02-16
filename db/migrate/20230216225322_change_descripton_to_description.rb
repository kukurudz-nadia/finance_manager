class ChangeDescriptonToDescription < ActiveRecord::Migration[7.0]
  def change
    rename_column :categories, :descripton, :description
 end
end
