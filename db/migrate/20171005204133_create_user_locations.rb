class CreateUserLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_locations do |t|
      t.integer :user_id, foreign_key: true
      t.integer :location_id, foreign_key: true

      t.timestamps
    end
  end
end
