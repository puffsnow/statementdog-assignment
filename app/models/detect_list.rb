# == Schema Information
#
# Table name: detect_lists
#
#  id         :integer          not null, primary key
#  name       :string
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
  belongs_to :user
  has_many :detect_items
  has_many :stocks, through: :detect_items

end
