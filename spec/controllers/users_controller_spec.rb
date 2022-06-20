require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET /' do
    let!(:users) { create_list(:user, 3) }
    it 'assign @users' do
      get 'index'

      expect(assigns(:users).length).to eq(3)
    end
  end

  describe 'GET /:id/become' do
    context 'user exist' do
      let(:user) { create(:user) }
      subject { get "become", params: { id: user.id } }

      it 'create user session' do
        expect { subject }.to change { UserSession.count }.by(1)
        expect(UserSession.first.user_id).to eq(user.id)
      end

      it 'assign token to http session' do
        subject

        expect(session[:auth_token]).to eq(user.user_sessions.first.token)
      end

      it 'redirect to detect list index' do
        subject

        expect(response).to redirect_to(detect_lists_path)
      end
    end
  end
end
