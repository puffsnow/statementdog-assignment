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
class UserSession < ApplicationRecord
  ACTIVE_DURATION = 30.days.freeze

  validates :token, presence: true
  validates :expired_at, presence: true

  belongs_to :user

  scope :active, -> { where('expired_at > ?', Time.current) }

  after_initialize :assign_data, if: :new_record?

  def expired?
    self.expired_at < Time.current
  end

  private

  def assign_data
    self.expired_at = Time.current + ACTIVE_DURATION
    self.token = SecureRandom.hex(16)
  end
end
