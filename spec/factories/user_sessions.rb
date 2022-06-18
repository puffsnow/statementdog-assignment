# == Schema Information
#
# Table name: user_sessions
#
#  id         :integer          not null, primary key
#  expired_at :datetime         not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_user_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :user_session do
    association :user
  end
end
