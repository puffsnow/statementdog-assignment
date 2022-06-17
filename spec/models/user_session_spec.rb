require 'rails_helper'

RSpec.describe UserSession, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:token) }
    it { should validate_presence_of(:expired_at) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end
end
