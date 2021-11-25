class AddUuidToModifications < ActiveRecord::Migration[6.0]
  def change
    add_column :modifications, :uuid, :string
  end
end
