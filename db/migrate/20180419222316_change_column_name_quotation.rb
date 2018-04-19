class ChangeColumnNameQuotation < ActiveRecord::Migration[5.1]
  def change
    rename_column :quotations, :shipment_time, :event_time
  end
end
