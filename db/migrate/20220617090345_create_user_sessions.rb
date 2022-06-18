class CreateUserSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_sessions do |t|
      t.references :user, index: true, foreign_key: true
      t.string     :token, null: false
      t.datetime   :expired_at, null: false

      t.timestamps
    end
  end
end
