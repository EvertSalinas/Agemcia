class CreateQuotationsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :quotations do |t|
      t.date 'date'
      t.string 'name'
      t.string 'company'
      t.string 'address'
      t.string 'phone'
      t.string 'status'
    end
  end
end
