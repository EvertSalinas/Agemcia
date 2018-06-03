class ChangeDeliveryTimeType < ActiveRecord::Migration[5.2]
  def change
    change_column :quotations, :deliver_date, :datetime
    change_column :quotations, :deliver_time, :datetime
  end
end
