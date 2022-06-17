class DetectList < ApplicationRecord
  belongs_to :user
  has_many :detect_items
  has_many :stocks, through: :detect_items

end
