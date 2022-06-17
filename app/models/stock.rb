class Stock < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true
  validates :code, format: { with: /\A[0-9]{4}\z/, message: 'should format with 4 digit numbers' }

  has_many :detect_items
  has_many :detect_lists, through: :detect_items
end
