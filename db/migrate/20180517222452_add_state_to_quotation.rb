class AddStateToQuotation < ActiveRecord::Migration[5.1]
  def change
    remove_column :quotations, :status
    add_column    :quotations, :state, :string
  end
end
