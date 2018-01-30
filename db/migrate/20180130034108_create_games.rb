class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.boolean :completed, null: false, default: false
      t.integer :winner_id
      t.timestamps
    end
  end
end
