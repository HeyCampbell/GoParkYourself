class RemoveParkedAtFromSpots < ActiveRecord::Migration
  def change
    remove_column :spots, :parked_at
  end
end
