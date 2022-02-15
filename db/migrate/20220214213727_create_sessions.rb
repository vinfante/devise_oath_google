class CreateSessions < ActiveRecord::Migration[6.1]
  def up
    create_table :sessions do |t|
      t.string :token
      t.string :user_id

      t.timestamps
    end
  end

  def down
    drop_table :sessions
  end
end
