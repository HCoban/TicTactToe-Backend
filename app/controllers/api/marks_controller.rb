require 'tic_tac_toe'

class Api::MarksController < ApplicationController
  def create
    begin
      jwt = JWT.decode(move_params[:token], ENV["HMAC_SECRET"], true, { :algorithm => 'HS256' })  
    rescue
      jwt = false
    end
    
    unless jwt
      render json: "Unauthorized", status: 401
      return
    end

    game = Game.find_by(id: jwt.first["game_id"])
    if game
      tic_tac_toe = TicTacToe.new(game)
      player = move_params[:value].to_i == 1 ? game.first_player : game.second_player
      column = move_params[:move][0]
      row = move_params[:move][1].to_i
      @mark = tic_tac_toe.mark_cell(player, row, column)
      if @mark.valid?
        @mark.reload
        render :show
      else
        render json: "Invalid move", status: 422
      end
    else
      render json: "Not found", status: 404
    end
  end

  def move_params
    params.require(:move).permit(:token, :move, :value)
  end
end
