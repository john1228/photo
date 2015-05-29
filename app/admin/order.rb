ActiveAdmin.register Order do
  menu label: '订单'
  config.filters = false
  belongs_to :photographer
  navigation_menu :photographer
  actions :index, :show

end
