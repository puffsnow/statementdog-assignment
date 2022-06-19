# frozen_string_literal: true

RSpec.shared_context 'user signed in' do
  let(:user) { create(:user) }
  let(:user_session) { create(:user_session, user: user) }
  before { session['auth_token'] = user_session.token }
end
