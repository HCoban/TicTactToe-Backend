# == Schema Information
#
# Table name: marks
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :integer          not null
#  row        :integer          not null
#  column     :string           not null
#

class Mark < ApplicationRecord
  validates :game_id, :player_id, :row, :column, presence: true
  validates :game, uniqueness: { scope: [:row, :column], message: "has already value for this position" } 

  belongs_to :game
  belongs_to :player
end
