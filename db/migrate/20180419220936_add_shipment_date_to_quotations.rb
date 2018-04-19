class AddShipmentDateToQuotations < ActiveRecord::Migration[5.1]
  def change
    add_column :quotations, :pickup_date, :date
    add_column :quotations, :elaboration_date, :date
  end
end
