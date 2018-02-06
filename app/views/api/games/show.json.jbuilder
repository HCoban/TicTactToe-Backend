json.game do
  json.id @game.id
  json.token @jwt
  json.playerOne @game.first_player.name
  json.playerTwo @game.second_player.name
  json.completed @game.completed
  json.winner @game.winner&.name
end
json.marks do
  json.array!(@game.marks.each_with_index.to_a) do |mark, index|
    i = mark.column
    j = mark.row
    value = mark.player.mark_value
    json.move "#{i}#{j}"
    json.value mark.player.mark_value
    json.step index+1
  end 
end
