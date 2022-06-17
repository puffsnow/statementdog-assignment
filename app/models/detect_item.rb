class DetectItem < ApplicationRecord
  validates :detect_list_id, uniqueness: { scope: :stock_id }

  belongs_to :detect_list
  belongs_to :stock
end
