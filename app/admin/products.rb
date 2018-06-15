ActiveAdmin.register Product do
  menu priority: 3
  actions :index, :show, :edit, :new

  index do
    id_column
    column :quotation_id do |id|
      link_to(id.quotation_id, admin_quotations_path(id.quotation_id))
    end
    column :concept
    column :amount
    column :price
    actions
  end

  show do
    attributes_table do
      row :id
      row('quotation id:')    { |b| link_to b.quotation_id, admin_quotations_path(b.quotation_id) }
      row :concept
      row :amount
      row :price
    end
    active_admin_comments
  end
end
