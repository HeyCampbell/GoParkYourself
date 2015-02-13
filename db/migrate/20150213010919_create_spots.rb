class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :sign_id
      t.integer :user_id
      t.datetime :parked_at
      t.boolean :remind?
      t.datetime :expiration

      t.timestamps
    end
  end
end
