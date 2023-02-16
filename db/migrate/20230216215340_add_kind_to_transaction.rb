class AddKindToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :kind, :string
  end
end
