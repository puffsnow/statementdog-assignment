# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many(:detect_lists) }
  end
end
