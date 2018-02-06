class AddWonToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :won, :boolean, null: false, default: false
  end
end
