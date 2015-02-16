class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.boolean :suspended?
      t.datetime :created

    end
  end
end
