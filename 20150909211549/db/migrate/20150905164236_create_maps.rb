class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :api_key
      t.references :shop, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
