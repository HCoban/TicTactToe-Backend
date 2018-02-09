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

class TicTacToe
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def check_status
    marks = @game.marks
    return if marks.count < 5

    WINNING_POSITIONS.each do |winning_position|
      possible_win = winning_position.map { |position| marks.find_by(row: position.first, column: position.last) }
      # skip checking a win if there is an empty cell in the winning position
      next if possible_win.include?(nil)

      # if all three cells are marked by the same player it is a win
      if possible_win.all? { |w| w.player == possible_win.first.player }
        @game.complete
        winner = possible_win.first.player
        winner.assign_won
        return
      end
    end

    @game.complete if marks.count == 9
  end

  def mark_cell(player, row, column)
    mark = Mark.create(player_id: player.id, game_id: @game.id, column: column, row: row)
    check_status

    mark
  end
end