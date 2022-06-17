require 'rails_helper'

RSpec.describe DetectList, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:detect_items) }
    it { should have_many(:stocks) }
  end
end
