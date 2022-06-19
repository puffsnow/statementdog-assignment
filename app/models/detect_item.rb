# == Schema Information
#
# Table name: detect_items
#
#  id             :integer          not null, primary key
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  detect_list_id :integer
#  stock_id       :integer
#
# Indexes
#
#  index_detect_items_on_detect_list_id               (detect_list_id)
#  index_detect_items_on_detect_list_id_and_stock_id  (detect_list_id,stock_id) UNIQUE
#  index_detect_items_on_stock_id                     (stock_id)
#
# Foreign Keys
#
#  detect_list_id  (detect_list_id => detect_lists.id)
#  stock_id        (stock_id => stocks.id)
#
class DetectItem < ApplicationRecord
  include Swappable

  validates :detect_list_id, uniqueness: { scope: :stock_id }

  belongs_to :detect_list
  belongs_to :stock

  private

  def swappable_parent
    detect_list
  end
end
