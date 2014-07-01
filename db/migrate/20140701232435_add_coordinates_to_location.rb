class AddCoordinatesToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :long, :string
    add_column :locations, :lat, :string
  end
end
