class AddActiveToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :active, :boolean, default: true
  end
end
