class AddFieldToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :price, :decimal, precision: 10, scale: 2
  	add_column :products, :published, :boolean
  end
end
