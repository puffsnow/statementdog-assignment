class CreateDetectLists < ActiveRecord::Migration[6.1]
  def change
    create_table :detect_lists do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
