require 'rails_helper'

RSpec.describe UserSession, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:token) }
    it { should validate_presence_of(:expired_at) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end

  describe '#initialize' do
    context 'new record' do
      subject { UserSession.new }

      it { expect(subject.expired_at.to_date).to eq((Time.current + 30.days).to_date) }
      it { expect(subject.token).to be_present }
    end
  end
end
