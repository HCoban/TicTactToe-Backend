class AddPlayerIdToMarks < ActiveRecord::Migration[5.1]
  def change
    add_column :marks, :player_id, :integer, null: false
    add_index :marks, :player_id
  end
end
