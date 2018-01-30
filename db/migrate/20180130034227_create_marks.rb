class CreateMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :marks do |t|
      t.integer :game_id
      t.timestamps
    end

    add_index :marks, :game_id
  end
end
