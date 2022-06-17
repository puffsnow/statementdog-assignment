class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :name, null: false
      t.string :code, null: false

      t.timestamps
    end
  end
end
