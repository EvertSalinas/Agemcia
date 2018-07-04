ActiveAdmin.register Quotation do
  menu priority: 2

  index do
    id_column
    column :name
    column :company
    column :event_date
    column :paid
    column :state
    actions
  end

  show do
    attributes_table do
      row :name
      row :company
      row :address
      row :phone
      row :created_at
      row :updated_at
      row :event_date
      row :event_time
      row :pickup_time
      row :pickup_date
      row :elaboration_date
      row :paid
      row :state
      row :deliver_date
      row :deliver_time
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item :view, only: :show do
    link_to "Descompletar", admin_quotation_path(resource), method: 'put' if resource.completada?
  end

  controller do
    def update
      @quotation = Quotation.find(params[:id])
      if @quotation.descompletar!
        flash[:notice] = "Quotation descompletada."
        redirect_to admin_quotation_path(params[:id])
      end
    end
  end

  sidebar "Associations", only: [:show, :edit] do
    ul do
      li link_to "Productos", admin_products_path(q: { quotation_id_eq: resource } )
    end
  end
end
