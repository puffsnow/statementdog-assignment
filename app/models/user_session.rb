class UserSession < ApplicationRecord
  ACTIVE_DURATION = 30.days.freeze

  validates :token, presence: true
  validates :expired_at, presence: true

  belongs_to :user
end
