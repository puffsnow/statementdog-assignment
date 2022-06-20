# == Schema Information
#
# Table name: detect_lists
#
#  id         :integer          not null, primary key
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_detect_lists_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe DetectList, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:detect_items) }
    it { should have_many(:stocks) }

    context 'destroy' do
      let!(:detect_list) { create(:detect_list) }
      let!(:detect_item) { create(:detect_item, detect_list: detect_list) }

      subject { detect_list.destroy }

      it { expect { subject }.to change { DetectItem.count }.by(-1) }
    end
  end
end
