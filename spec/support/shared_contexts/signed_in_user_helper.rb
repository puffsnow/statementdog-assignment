# frozen_string_literal: true

RSpec.shared_context 'user signed in' do
  let(:user) { create(:user) }

  before do
    controller.stub(:authenticate!) { true }
    controller.stub(:current_user) { user }
  end
end
