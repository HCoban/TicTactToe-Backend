# == Schema Information
#
# Table name: marks
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :integer          not null
#

require 'rails_helper'

RSpec.describe Mark, type: :model do
  describe "validations" do
    it { should validate_presence_of(:game_id) }
    it { should validate_presence_of(:player_id) }
  end

  describe "associations" do
    it { should belong_to(:game) }
    it { should belong_to(:player) }
  end
end