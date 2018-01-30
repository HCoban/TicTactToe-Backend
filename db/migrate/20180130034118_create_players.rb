class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.integer :game_id, null: false
      t.string :name
      t.string :mark_value, null: false
      t.timestamps
    end

    add_index :players, :game_id
  end
end
