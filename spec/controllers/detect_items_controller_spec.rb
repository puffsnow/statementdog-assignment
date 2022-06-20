require 'rails_helper'

RSpec.describe DetectItemsController, type: :controller do
  describe 'DELETE /destroy', signed_in: :user do
    context 'delete detect item success' do
      let(:detect_list) { create(:detect_list, user: user) }
      let(:detect_item) { create(:detect_item, detect_list: detect_list) }

      subject { delete 'destroy', params: { id: detect_item.id } }

      it 'new detect list with correct data' do
        subject

        expect { detect_item.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET /move', signed_in: :user do
    context 'swap success' do
      let(:detect_list) { create(:detect_list, user: user) }
      let(:detect_items) { create_list(:detect_item, 3, detect_list: detect_list) }

      before do
        detect_items[0].update(position: 1)
        detect_items[1].update(position: 2)
        detect_items[2].update(position: 3)
      end

      it 'swap items positions with up' do
        get 'move', params: { id: detect_items[1].id, direction: 'up'}

        expect(detect_items[0].reload.position).to eq(2)
        expect(detect_items[1].reload.position).to eq(1)
      end

      it 'swap items positions with down' do
        get 'move', params: { id: detect_items[1].id, direction: 'down'}

        expect(detect_items[1].reload.position).to eq(3)
        expect(detect_items[2].reload.position).to eq(2)
      end

      it 'nothing happened when appraoch bound' do
        get 'move', params: { id: detect_items[2].id, direction: 'down'}

        expect(detect_items[2].reload.position).to eq(3)
      end

      it 'redirect to list page' do
        get 'move', params: { id: detect_items[1].id, direction: 'down'}

        expect(response).to redirect_to(detect_lists_path)
      end
    end
  end
end
