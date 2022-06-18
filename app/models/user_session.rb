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
