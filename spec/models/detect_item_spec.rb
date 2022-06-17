require 'rails_helper'

RSpec.describe DetectItem, type: :model do
  describe 'validates' do
    context 'conflict pair' do
      let!(:detect_item) { create(:detect_item) }

      it 'validate false' do
        new_detect_item = DetectItem.new(detect_list: detect_item.detect_list, stock: detect_item.stock)

        expect(new_detect_item.valid?).to be_falsy
      end
    end
  end

  describe 'relationships' do
    it { should belong_to(:stock) }
    it { should belong_to(:detect_list) }
  end
end
