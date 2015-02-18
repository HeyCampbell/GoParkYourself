class AddSideToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :side, :string
  end
end
