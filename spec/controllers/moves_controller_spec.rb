require 'rails_helper'

RSpec.describe Api::MovesController, type: :controller do
  describe "create" do
    it("decodes token and queries game") do
      game = Game.create(id: 1)
      player_one = Player.create(game_id: game.id, mark_value: "X")
      player_two = Player.create(game_id: game.id, mark_value: "O")
      jwt = class_double(JWT).as_stubbed_const

      allow(jwt).to receive(:decode).and_return([{ "game_id" => 1}, nil])

      post(:create, {
        params: {
          move: {
            token: "token",
            move: "A1",
            value: "X"
          }
        },
        format: :json
      })
    end

    it("returns success for authorized requests") do
      game = Game.create(id: 1)
      player_one = Player.create(game_id: game.id, mark_value: "X")
      player_two = Player.create(game_id: game.id, mark_value: "O")
      jwt = class_double(JWT).as_stubbed_const

      allow(jwt).to receive(:decode).and_return([{ "game_id" => 1}, nil])

      post(:create, {
        params: {
          move: {
            token: "token",
            move: "A1",
            value: "1"
          }
        },
        format: :json
      })

      expect(response.status).to eq(200)
    end

    it("returns 401 when unauthorized") do
      game = Game.create(id: 1)
      player_one = Player.create(game_id: game.id, mark_value: "X")
      player_two = Player.create(game_id: game.id, mark_value: "O")
      jwt = class_double(JWT).as_stubbed_const

      allow(jwt).to receive(:decode).and_raise

      post(:create, {
        params: {
          move: {
            token: "token",
            move: "A1",
            value: "X"
          }
        },
        format: :json
      })

      expect(response.status).to eq(401)
    end

    it("returns 404 when game not found") do
      game = Game.create(id: 1)
      player_one = Player.create(game_id: game.id, mark_value: "X")
      player_two = Player.create(game_id: game.id, mark_value: "O")
      jwt = class_double(JWT).as_stubbed_const

      allow(jwt).to receive(:decode).and_return([{ "game_id" => 5 }, nil])

      post(:create, {
        params: {
          move: {
            token: "token",
            move: "A1",
            value: "X"
          }
        },
        format: :json
      })

      expect(response.status).to eq(404)
    end
  end
end
