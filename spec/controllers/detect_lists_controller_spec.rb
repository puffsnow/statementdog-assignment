require 'rails_helper'

RSpec.describe DetectListsController, type: :controller do
  describe "GET /", signed_in: :user do
    let!(:detect_lists) { create_list(:detect_list, 3, user: user) }
    it 'assign @detect_lists' do
      get 'index'

      expect(assigns(:detect_lists).length).to eq(3)
    end
  end

  describe 'POST /', signed_in: :user do
    context 'create detect list success' do
      let(:name) { FFaker::Name.name }
      subject { post "create", params: { detect_list: { name: name }} }

      it { expect { subject }.to change { user.detect_lists.count }.by(1) }
      it 'new detect list with correct data' do
        subject

        expect(user.detect_lists.first.name).to eq(name)
      end

      it 'redirect to detect lists index' do
        subject

        expect(response).to redirect_to(detect_lists_path)
      end
    end
  end

  describe 'GET /edit', signed_in: :user do
    context 'read detect list success' do
      let(:detect_list) { create(:detect_list, user: user) }
      subject { get 'edit', params: { id: detect_list.id } }

      it 'new detect list with correct data' do
        subject

        expect(flash[:alert]).to be_nil
        expect(assigns(:detect_list)).to eq(detect_list)
      end
    end

    context 'detect list not own by user' do
      let(:another_user) { create(:user) }
      let(:detect_list) { create(:detect_list, user: another_user) }

      it 'redirect to list index page and get error message' do
        get 'edit', params: { id: detect_list.id }

        expect(flash[:alert]).to be_present
        expect(response).to redirect_to(detect_lists_path)
      end
    end

    context 'detect list not exist' do
      it 'redirect to list index page and get error message' do
        get 'edit', params: { id: 20 }

        expect(flash[:alert]).to be_present
        expect(response).to redirect_to(detect_lists_path)
      end
    end
  end

  describe 'PATCH /update', signed_in: :user do
    context 'update detect list success' do
      let(:new_name) { FFaker::Name.name }
      let(:detect_list) { create(:detect_list, user: user) }

      subject { patch 'update', params: { id: detect_list.id, detect_list: { name: new_name } } }

      it 'new detect list with correct data' do
        subject

        expect(flash[:alert]).to be_nil
        expect(detect_list.reload.name).to eq(new_name)
      end
    end
  end

  describe 'DELETE /destroy', signed_in: :user do
    context 'delete detect list success' do
      let(:detect_list) { create(:detect_list, user: user) }

      subject { delete 'destroy', params: { id: detect_list.id } }

      it 'new detect list with correct data' do
        subject

        expect(flash[:alert]).to be_nil
        expect { detect_list.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET /move', signed_in: :user do
    context 'swap success' do
      let(:detect_lists) { create_list(:detect_list, 3, user: user) }

      before do
        detect_lists[0].update(position: 1)
        detect_lists[1].update(position: 2)
        detect_lists[2].update(position: 3)
      end

      it 'swap lists positions with up' do
        get 'move', params: { id: detect_lists[1].id, direction: 'up'}

        expect(detect_lists[0].reload.position).to eq(2)
        expect(detect_lists[1].reload.position).to eq(1)
      end

      it 'swap lists positions with down' do
        get 'move', params: { id: detect_lists[1].id, direction: 'down'}

        expect(detect_lists[1].reload.position).to eq(3)
        expect(detect_lists[2].reload.position).to eq(2)
      end

      it 'nothing happened when appraoch bound' do
        get 'move', params: { id: detect_lists[2].id, direction: 'down'}

        expect(detect_lists[2].reload.position).to eq(3)
      end

      it 'redirect to list page' do
        get 'move', params: { id: detect_lists[1].id, direction: 'down'}

        expect(response).to redirect_to(detect_lists_path)
      end
    end
  end
end
