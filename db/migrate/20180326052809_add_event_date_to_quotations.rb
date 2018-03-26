class AddEventDateToQuotations < ActiveRecord::Migration[5.1]
  def change
    rename_column :quotations, :date, :event_date
  end
end
