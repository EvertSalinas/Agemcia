class AddHoursColumnsToQuotation < ActiveRecord::Migration[5.1]
  def change
    add_column :quotations, :shipment_time, :datetime
    add_column :quotations, :pickup_time, :datetime
  end
end
