class CreateProductsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string 'concept'
      t.integer 'amount'
      t.monetize 'price'
      t.belongs_to :quotation
    end
  end
end
