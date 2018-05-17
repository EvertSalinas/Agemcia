class AddPaidStateToQuotation < ActiveRecord::Migration[5.1]
  def change
    add_column :quotations, :paid, :string
  end
end
