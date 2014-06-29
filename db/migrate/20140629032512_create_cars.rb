class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :color, null: false
      t.string :year, null: false
      t.string :mileage, null: false
      t.integer :manufacturer_id, null: false
      t.string :description

      t.timestamps
    end
  end
end
