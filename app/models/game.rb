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

  WINNING_POSITIONS = [
    # horizontals
    [[1, "A"], [1, "B"], [1, "C"]],
    [[2, "A"], [2, "B"], [2, "C"]],
    [[3, "A"], [3, "B"], [3, "C"]],
    # verticals
    [[1, "A"], [2, "A"], [3, "A"]],
    [[1, "B"], [2, "B"], [3, "B"]],
    [[1, "C"], [2, "C"], [3, "C"]],
    # diagonals
    [[1, "A"], [2, "B"], [3, "C"]],
    [[3, "A"], [2, "B"], [1, "C"]]
  ]

  def first_player
    self.players.find_by(mark_value: "X")
  end

  def second_player
    self.players.find_by(mark_value: "O")
  end

  def check_status
    return if marks.count < 5
    WINNING_POSITIONS.each do |winning_position|
      possible_win = winning_position.map { |position| marks.find_by(row: position.first, column: position.last) }
      next if possible_win.include?(nil)
      if possible_win.all? { |w| w.player == possible_win.first.player }
        self.update(completed: true)
        possible_win.first.player.update(won: true)
        return
      end
    end

    self.update(completed: true) if marks.count == 9
  end

  def winner
    self.players.find_by(won: true)
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
