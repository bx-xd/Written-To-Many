class CreateModifications < ActiveRecord::Migration[6.0]
  def change
    create_table :modifications do |t|
      t.text :content_before
      t.text :content_after
      t.text :context
      t.string :status
      t.references :text, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
