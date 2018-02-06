class Api::GamesController < ApplicationController
  def create
    @game = Game.create_with_players(game_params[:player_one_name], game_params[:player_two_name])
    if @game
      @jwt = JWT.encode({game_id: @game.id }, ENV["HMAC_SECRET"], 'HS256')
      render :show
    else
      render json: "Game could not be created", status: 422
    end
  end

  def show
    @game = Game.find_by(id: params[:id])
    if @game
      render :show
    else
      render json: "Game not found", status: 404
    end
  end

  def game_params
    params.require(:game).permit(:player_one_name, :player_two_name, :token)
  end
end
