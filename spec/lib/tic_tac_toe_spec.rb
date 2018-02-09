describe "TicTacToe" do
  describe "#initialize" do
    it "assign game to an instance variable" do
      game = Game.create
      tic_tac_toe = TicTacToe.new(game)
      expect(tic_tac_toe.game).to eq(game)
    end
  end

  describe "#check_status" do
    before(:each) do
      @game = Game.create
      @player_one = Player.create(game_id: @game.id, mark_value: "X")
      @player_two = Player.create(game_id: @game.id, mark_value: "O")
      @tic_tac_toe = TicTacToe.new(@game)
    end

    it "does not modify game instance if game is ongoing" do
      @tic_tac_toe.check_status
      expect(@game.reload.completed).to eq(false)
    end

    it "completes the game and assigns winner when there is one" do
      ["A", "B", "C"].each do |col|
        Mark.create(game_id: @game.id, player_id: @player_one.id, column: col, row: 1)
      end
      Mark.create(game_id: @game.id, player_id: @player_two.id, column: "A", row: 2)
      Mark.create(game_id: @game.id, player_id: @player_two.id, column: "B", row: 2)

      @tic_tac_toe.check_status
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
      @tic_tac_toe.check_status

      expect(@game.reload.completed).to eq(true)
      expect(@player_one.reload.won).to eq(false)
      expect(@player_two.reload.won).to eq(false)
    end
  end
end