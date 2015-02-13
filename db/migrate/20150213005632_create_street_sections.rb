class CreateStreetSections < ActiveRecord::Migration
  def change
    create_table :street_sections do |t|

      t.string :borough
      t.string :status_order
      t.string :main_street
      t.string :from_street
      t.string :to_street
      t.string :side_of_street
      t.decimal :latitude_from, :precision => 10, :scale => 6
      t.decimal :longitude_from, :precision => 10, :scale => 6
      t.decimal :latitude_to, :precision => 10, :scale => 6
      t.decimal :longitude_to, :precision => 10, :scale => 6

      t.timestamps
    end
  end
end
