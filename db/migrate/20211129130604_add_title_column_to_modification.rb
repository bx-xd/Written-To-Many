class AddTitleColumnToModification < ActiveRecord::Migration[6.0]
  def change
    add_column :modifications, :title, :string
  end
end
