ActiveAdmin.register Photographer do
  menu label: '摄影师'
  permit_params :name, :avatar, :level, :price, :city

  filter :name, label: '名字'

  index do
    selectable_column
    column('名字', :name)
    column('头像') { |photographer| image_tag(photographer.avatar.thumb.url) }
    column('级别', :level)
    column('价格', :price)
    column('服务城市', :city)
    actions
  end

  show do
    table style: 'width: 100%' do
      tr do
        td link_to('作品', admin_photographer_works_path(photographer), class: :button)
        td link_to('订单', admin_photographer_orders_path(photographer), class: :button)
      end
    end
  end


  sidebar '摄影师', only: :show do
    attributes_table_for photographer do
      row('名字') { photographer.name }
      row('头像') { image_tag(photographer.avatar.thumb.url) }
      row('级别') { photographer.level }
      row('价格') { photographer.price }
      row('服务城市') { photographer.city }
    end
  end

  form html: {enctype: 'multipart/form-data'} do |f|
    f.inputs '摄影师' do
      f.input :name
      f.input :avatar
      f.input :level, as: :select, collection: [['钻石', 1], ['皇冠', 2]], include_blank: false
      f.input :price
      f.input :city
    end
    f.submit('确定')
  end

end
