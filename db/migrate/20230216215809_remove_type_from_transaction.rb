class RemoveTypeFromTransaction < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :type, :string
  end
end
