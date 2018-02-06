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

  describe "check status" do
    before(:each) do
      @game = Game.create
      @player_one = Player.create(game_id: @game.id, mark_value: "X")
      @player_two = Player.create(game_id: @game.id, mark_value: "O")
    end

    it "does not modify game instance if game is ongoing" do
      @game.check_status
      expect(@game.reload.completed).to eq(false)
    end

    it "completes the game and assigns winner when there is one" do
      ["A", "B", "C"].each do |col|
        Mark.create(game_id: @game.id, player_id: @player_one.id, column: col, row: 1)
      end
      Mark.create(game_id: @game.id, player_id: @player_two.id, column: "A", row: 2)
      Mark.create(game_id: @game.id, player_id: @player_two.id, column: "B", row: 2)

      @game.check_status
      expect(@game.reload.completed).to eq(true)
      expect(@player_one.reload.won).to eq(true)
      expect(@player_two.reload.won).to eq(false)
    end

    it "completes the game even if no winner after nine steps" do
      player_one_marks = %w[A1 B1 C2 A3 C3]
      player_one_marks.each do |mark|
        col = mark[0]
        row = mark[1]
        Mark.create(player_id: @player_one.id, game_id: @game.id, column: col, row: row)
      end
      player_two_marks = %w[C1 A2 B2 B3]
      player_two_marks.each do |mark|
        col = mark[0]
        row = mark[1]
        Mark.create(player_id: @player_two.id, game_id: @game.id, column: col, row: row)
      end
      @game.check_status

      expect(@game.reload.completed).to eq(true)
      expect(@player_one.reload.won).to eq(false)
      expect(@player_two.reload.won).to eq(false)
    end
  end
end