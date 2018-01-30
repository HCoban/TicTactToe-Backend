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
#

require 'rails_helper'

RSpec.describe Player, type: :model do
  describe "validations" do
    it { should validate_presence_of(:game_id) }
    it { should validate_presence_of(:mark_value) }
  end

  describe "associations" do
    it { should belong_to(:game) }
  end
end
