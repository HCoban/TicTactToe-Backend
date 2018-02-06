require 'rails_helper'

RSpec.describe Api::GamesController, type: :controller do
  describe "#create" do
    it "calls #create_with_players" do
      game = class_double("Game").as_stubbed_const
      expect(game).to receive(:create_with_players).with("p1", "p2")
      
      post(:create, {
        params: {
          game: {
            player_one_name: "p1",
            player_two_name: "p2"
          }
        },
        format: :json
      })
    end

    it "returns 200" do
      post(:create, {
        params: {
          game: {
            player_one_name: "p1",
            player_two_name: "p2"
          }
        },
        format: :json
      })

      expect(response.status).to eq(200)
    end
  end

  describe "show" do
    it "returns success if there is such game" do
      game = Game.create(id: 1)
      get(:show, {
        params: {
          id: 1
        },
        format: :json
      })

      expect(response.status).to eq(200)
    end

    it "returns 404 if game is not found" do
      game = Game.create(id: 1)
      
      get(:show, {
        params: {
          id: 2
        },
        format: :json
      })

      expect(response.status).to eq(404)
    end
  end
end
