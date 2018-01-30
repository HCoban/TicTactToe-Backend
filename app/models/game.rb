# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  completed  :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ApplicationRecord
  validates :completed, presence: true

  has_many :players
end
