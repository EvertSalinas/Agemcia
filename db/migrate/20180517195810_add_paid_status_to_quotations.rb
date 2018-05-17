class AddPaidStatusToQuotations < ActiveRecord::Migration[5.1]
  def change
    add_column :quotations, :paid, :boolean
  end
end
