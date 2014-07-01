class CreateLocation < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :place
      t.integer :radius
      t.integer :user_id
      t.timestamps
    end
  end
end
