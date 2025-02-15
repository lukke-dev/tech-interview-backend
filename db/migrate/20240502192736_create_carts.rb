class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.boolean :abandoned, default: false
      t.timestamps
    end
  end
end
