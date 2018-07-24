class AddIvaAttributeToQuotations < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :with_iva, :boolean, default: true, nil: false
  end
end
