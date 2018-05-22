class AddDeliverDate < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :deliver_date, :date
    add_column :quotations, :deliver_time, :date
  end
end
