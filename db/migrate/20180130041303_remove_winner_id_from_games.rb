class RemoveWinnerIdFromGames < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :winner_id
  end
end
