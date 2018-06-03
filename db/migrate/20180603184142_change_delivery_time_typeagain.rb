class ChangeDeliveryTimeTypeagain < ActiveRecord::Migration[5.2]
  def change
    change_column :quotations, :deliver_date, :date
  end
end
