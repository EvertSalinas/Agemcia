ActiveAdmin.register User do
  menu priority: 1
  # permit_params :first_name, :last_name
  #config.clear_action_items!

  index do
    id_column
    # column :first_name
    # column :last_name
    column :email
    column :created_at
    column :updated_at
    actions
  end

  show title: 'User' do
    attributes_table do
      row :id
      # row :first_name
      # row :last_name
      row :email
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
