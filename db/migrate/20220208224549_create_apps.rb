class CreateApps < ActiveRecord::Migration[6.1]
  def change
    create_table :apps do |t|

      t.timestamps
    end
  end
end
