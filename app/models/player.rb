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

  belongs_to :game
end
