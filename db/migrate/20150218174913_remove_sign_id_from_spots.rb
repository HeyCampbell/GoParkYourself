class RemoveSignIdFromSpots < ActiveRecord::Migration
  def change
    remove_column :spots, :sign_id
  end
end
