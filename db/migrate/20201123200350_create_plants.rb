class CreatePlants < ActiveRecord::Migration[6.0]
  def change
    create_table :plants do |t|
      t.references :family, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :water_frequency
      t.integer :light_frequency
      t.integer :fertilizer_frequency
      t.string :api_photo

      t.timestamps
    end
  end
end
