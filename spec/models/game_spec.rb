# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  completed  :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "associations" do
    it { should have_many(:players) }
  end

  describe "::create_with_players" do
    it "creates a game and two players" do
      game = Game.create_with_players(nil, nil)
      expect(Game.order(created_at: :asc).last).to eq(game)
      expect(game.players.count).to eq(2)
    end

    it "adds default name for player 1" do
      game = Game.create_with_players(nil, "second")
      expect(game.first_player.name).to eq("Player#1")
      expect(game.second_player.name).to eq("second")
    end

    it "adds default name for player 2" do
      game = Game.create_with_players("first", nil)
      expect(game.first_player.name).to eq("first")
      expect(game.second_player.name).to eq("Player#2")
    end
  end

  describe "player getters" do
    before do
      @game = Game.create
      @player_one = Player.create(game_id: @game.id, mark_value: "X")
      @player_two_winner = Player.create(game_id: @game.id, mark_value: "O", won: true)
    end

    it "first_player returns player with value 'X'" do
      expect(@game.first_player).to eq(@player_one)      
    end

    it "second_player returns player with value 'O'" do
      expect(@game.second_player).to eq(@player_two_winner)      
    end

    it "winner returns player with won: true" do
      expect(@game.winner).to eq(@player_two_winner)
    end
  end
end