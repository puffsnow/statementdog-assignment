# == Schema Information
#
# Table name: detect_items
#
#  id             :integer          not null, primary key
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  detect_list_id :integer
#  stock_id       :integer
#
# Indexes
#
#  index_detect_items_on_detect_list_id               (detect_list_id)
#  index_detect_items_on_detect_list_id_and_stock_id  (detect_list_id,stock_id) UNIQUE
#  index_detect_items_on_stock_id                     (stock_id)
#
# Foreign Keys
#
#  detect_list_id  (detect_list_id => detect_lists.id)
#  stock_id        (stock_id => stocks.id)
#
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

  describe 'swappable' do
    let(:detect_list) { create(:detect_list) }
    let!(:detect_items) { create_list(:detect_item, 3, detect_list: detect_list) }
    before do
      detect_items[0].update(position: 1)
      detect_items[1].update(position: 2)
      detect_items[2].update(position: 3)
    end

    context 'direction item exist' do
      context 'up' do
        it 'should swap each postion when up' do
          detect_items[1].move(direction: 'up')

          expect(detect_items[0].reload.position).to eq(2)
          expect(detect_items[1].reload.position).to eq(1)
        end
      end

      context 'down' do
        it 'should swap each postion when up' do
          detect_items[1].move(direction: 'down')

          expect(detect_items[1].reload.position).to eq(3)
          expect(detect_items[2].reload.position).to eq(2)
        end
      end
    end

    context 'direction item not exist' do
      context 'up' do
        it 'should keep original postion ' do
          detect_items[0].move(direction: 'up')

          expect(detect_items[0].reload.position).to eq(1)
        end
      end

      context 'down' do
        it 'should keep original postion ' do
          detect_items[2].move(direction: 'down')

          expect(detect_items[2].reload.position).to eq(3)
        end
      end
    end
  end
end
