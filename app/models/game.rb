# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  completed  :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ApplicationRecord
  validates :completed, inclusion: { in: [true, false] }

  has_many :players
  has_many :marks

  def first_player
    self.players.find_by(mark_value: "X")
  end

  def second_player
    self.players.find_by(mark_value: "O")
  end

  def winner
    self.players.find_by(won: true)
  end

  def complete
    self.update(completed: true)
  end

  def self.create_with_players(player_one_name, player_two_name)
    player_one_name ||= "Player#1"
    player_two_name ||= "Player#2"
    game = self.new
    return game unless game.save

    player_one = Player.new(game: game, name: player_one_name, mark_value: "X")
    player_two = Player.new(game: game, name: player_two_name, mark_value: "O")
    if player_one.valid? && player_two.valid?
      player_one.save
      player_two.save
      game
    else
      return false
    end
  end
end
