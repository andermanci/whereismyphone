class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.references :device
      t.column :long, :string
      t.column :lat, :string

      t.timestamps
    end
  end
end
