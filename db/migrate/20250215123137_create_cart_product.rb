class CreateCartProduct < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_products do |t|
      t.integer :cart_id
      t.integer :product_id
      t.integer :quantity

      t.timestamps
    end

    add_index :cart_products, [:cart_id, :product_id], unique: true
  end
end