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
class DetectList < ApplicationRecord
  include Swappable

  belongs_to :user
  has_many :detect_items, dependent: :destroy
  has_many :display_detect_items, -> { order(:position) }, class_name: 'DetectItem'
  has_many :stocks, through: :detect_items

  private

  def swappable_parent
    user
  end
end
