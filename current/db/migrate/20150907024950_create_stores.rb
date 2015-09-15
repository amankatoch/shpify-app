class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.references :shop, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
