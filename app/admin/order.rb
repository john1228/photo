ActiveAdmin.register Order do
  menu label: '订单'
  config.filters = false
  belongs_to :photographer
  navigation_menu :photographer
  actions :index, :show
  index do
    column('订单编号', :order_no)
    column('作品') { |order| Works.find_by(id: order.works_id).title }
    column('预约日期') { |order| order.appoint_date.strftime('%Y-%m-%d') }
    column('预约时间') { |order| order.eql?(0) ? '9:00' : '13:00' }
    column('预约地址', :appoint_address)
    column('联系人', :contact)
    column('联系电话', :phone)
    column('支付类型', :pay_type)
    actions
  end
end
