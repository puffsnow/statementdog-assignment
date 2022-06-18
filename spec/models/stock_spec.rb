# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }

    context 'code format validation' do
      it { expect(described_class.new(name: FFaker::Name.name, code: '0123').valid?).to be_truthy }
      it { expect(described_class.new(name: FFaker::Name.name, code: 'abcd').valid?).to be_falsy }
      it { expect(described_class.new(name: FFaker::Name.name, code: '111').valid?).to be_falsy }
    end
  end

  describe 'relationships' do
    it { should have_many(:detect_items) }
    it { should have_many(:detect_lists) }
  end
end
