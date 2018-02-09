# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  game_id    :integer          not null
#  name       :string
#  mark_value :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  won        :boolean          default("false"), not null
#

class Player < ApplicationRecord
  validates :game_id, :mark_value, presence: true
  validates :mark_value, inclusion: { in: ["X", "O"] }

  belongs_to :game

  def assign_won
    self.update(won: true)
  end
end
