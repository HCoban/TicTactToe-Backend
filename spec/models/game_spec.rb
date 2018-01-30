# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  completed  :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "validations" do
    it { should validate_presence_of (:completed) }
  end

  describe "associations" do
    it { should have_many(:players) }
  end
end
