class User < ApplicationRecord
  validates :name, presence: true

  has_many :detect_lists
  has_many :user_sessions
end
