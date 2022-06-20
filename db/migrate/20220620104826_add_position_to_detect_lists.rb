class AddPositionToDetectLists < ActiveRecord::Migration[6.1]
  def change
    add_column :detect_lists, :position, :integer, after: :name
  end
end
