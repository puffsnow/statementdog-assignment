require 'rails_helper'

RSpec.describe DetectLists::DetectItemsController, type: :controller do
  describe "GET /new", signed_in: :user do
    context 'success case' do
      let(:detect_list) { create(:detect_list, user: user) }

      it 'assign @detect_list' do
        get 'new', params: { detect_list_id: detect_list.id }

        expect(assigns(:detect_list)).to be_present
      end
    end

    context 'detect list not own by user' do
      let(:another_user) { create(:user) }
      let(:detect_list) { create(:detect_list, user: another_user) }

      it 'redirect to list index page and get error message' do
        get 'new', params: { detect_list_id: detect_list.id }

        expect(flash[:alert]).to be_present
        expect(response).to redirect_to(detect_lists_path)
      end
    end

    context 'detect list not exist' do
      it 'redirect to list index page and get error message' do
        get 'new', params: { detect_list_id: 20 }

        expect(flash[:alert]).to be_present
        expect(response).to redirect_to(detect_lists_path)
      end
    end
  end

  describe "POST /create", signed_in: :user do
    let(:stock) { create(:stock) }
    let(:detect_list) { create(:detect_list, user: user) }

    subject { post 'create', params: { detect_list_id: detect_list.id, code: stock.code } }

    context 'stock not in list yet' do
      it { expect { subject }.to change { detect_list.detect_items.count }.by(1) }
      it 'redirect to list page' do
        subject

        expect(response).to redirect_to(detect_lists_path)
      end
    end

    context 'stock already in list' do
      it 'not add additional one' do
        detect_list.stocks << stock

        expect { subject }.to change { detect_list.detect_items.count }.by(0)
      end
    end

    context 'stock not exist' do
      it 'response error and redirect' do
        stock.destroy
        subject

        expect(flash[:alert]).to be_present
        expect(response).to redirect_to(detect_lists_path)
      end
    end
  end
end
