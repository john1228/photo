ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: '首页'

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
      end
    end
  end
end
