class AddPositionsToMarks < ActiveRecord::Migration[5.1]
  def change
    add_column :marks, :row, :integer, null: false
    add_column :marks, :column, :string, null: false
  end
end
