class CreateSigns < ActiveRecord::Migration
  def change
    create_table :signs do |t|
      t.string :status_order
      t.integer :sign_sequence
      t.integer :distance
      t.string :arrow
      t.string :sign_description
      t.string :parsed_description

      t.timestamps
    end
  end
end
