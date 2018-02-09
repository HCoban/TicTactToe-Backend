# == Schema Information
#
# Table name: marks
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :integer          not null
#  row        :integer          not null
#  column     :string           not null
#

require 'rails_helper'

RSpec.describe Mark, type: :model do
  describe "validations" do
    it { should validate_presence_of(:game_id) }
    it { should validate_presence_of(:player_id) }
    it { should validate_presence_of(:row) }
    it { should validate_presence_of(:column) }
    it "validates uniqueness of game scoped to row and column" do
      game = Game.create
      player = Player.create(game_id: game.id, mark_value: "X")
      Mark.create(player_id: player.id, game_id: game.id, row: 1, column: "A")
      new_move = Mark.new(player_id: player.id, game_id: game.id, row: 1, column: "A")
      expect(new_move).to be_invalid
      expect(new_move.errors.full_messages).to include("Game has already value for this position")
    end
  end

  describe "associations" do
    it { should belong_to(:game) }
    it { should belong_to(:player) }
  end
end
