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
  validates :game_id, presence: true
  validates :player_id, presence: true

  belongs_to :game
  belongs_to :player
end
