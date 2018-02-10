i = @mark.column
j = @mark.row
value = @mark.player.mark_value
json.move "#{i}#{j}"
json.value @mark.player.mark_value
json.game do
  json.id @mark.game.id
  json.completed @mark.game.completed
  json.winner @mark.player.won
end