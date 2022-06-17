class CreateDetectItems < ActiveRecord::Migration[6.1]
  def change
    create_table :detect_items do |t|
      t.references :detect_list, index: true, foreign_key: true
      t.references :stock, index: true, foreign_key: true
      t.integer :position

      t.timestamps
    end

    add_index :detect_items, [:detect_list_id, :stock_id], unique: true
  end
end
