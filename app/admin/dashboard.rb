ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column max_width: '400px' do
        render partial: 'admin/column_one'
      end
      column max_width: '600px' do
        render partial: 'admin/column_two'
      end
      column max_width: '400px' do
        render partial: 'admin/column_three'
      end
    end
  end
end
