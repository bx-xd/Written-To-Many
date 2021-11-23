class UpdateReferencesInDiscussions < ActiveRecord::Migration[6.0]
  def change
    remove_reference :discussions, :project
    remove_reference :discussions, :modification

    add_reference :discussions, :project, foreign_key: true
    add_reference :discussions, :modification, foreign_key: true
  end
end
