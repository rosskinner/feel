class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|
      t.string :mood
      t.integer :count
      t.integer :location_id
      t.timestamps
    end
  end
end
