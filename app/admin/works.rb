ActiveAdmin.register Works do
  menu label: '作品'

  belongs_to :photographer
  navigation_menu :photographer

  permit_params :photographer_id, :title, :works_type, :during, :price, :discount, :intro, :age,
                works_photos_attributes: [:id, :photo]

  filter :title, label: '名称'
  index do
    selectable_column
    column('名称', :title)
    column('类型', :works_type)
    column('持续时间') { |works| "#{works.during}小时" }
    column('店铺价') { |works| "#{works.price}元" }
    column('折扣价') { |works| "#{works.discount}元" }
    column('介绍') { |works| truncate(works.intro) }
    actions
  end

  show do
    paginated_collection(works.orders.page(params[:page]).per(5), param_name: :page) do
      table_for(collection, class: 'index_table') do
        column('订单号', :order_no)
        column('预约时间') { |order| "#{order.appoint_date} #{order.appoint_time}" }
        column('联系人', :contact)
        column('联系电话', :phone)
        column('支付类型', :pay_type)
        column('状态') { |order| order.status_i18n }
      end
    end
  end

  sidebar '作品详情', only: :show do
    div class: 'attributes_table' do
      table do
        tr class: "row row-" do
          th '名称'
          td works.title
        end
        tr class: "row row-" do
          th '类型'
          td works.works_type
        end
        tr class: "row row-" do
          th '持续时间'
          td "#{works.during}小时"
        end
        tr class: "row row-" do
          th '店铺'
          td "#{works.price}元"
        end
        tr class: "row row-" do
          th '折扣价'
          td "#{works.discount}元"
        end
        tr class: "row row-" do
          th '介绍'
          td works.intro
        end
        tr class: "row row-" do
          th '图片'
          td do
            div do
              for works_photo in works.works_photos
                div image_tag(works_photo.photo.thumb.url, width: 69*2)
              end
            end
          end
        end
      end
    end
  end

  form html: {enctype: 'multipart/form-data'} do |f|
    f.inputs '作品' do
      f.input :photographer_id, as: :hidden
      f.input :title, label: '名称'
      f.input :age, label: '类型', as: :select, collection: Works::AGE, iclude_blank: false
      f.input :works_type, label: '类型', as: :select, collection: Works::TYPE, iclude_blank: false
      f.input :cover, label: '封面', as: :file
      f.input :during, label: '持续时间(小时)'
      f.input :price, label: '价格(元)'
      f.input :discount, label: '折扣价(元)'
      f.input :intro, label: '介绍', input_html: {cols: 5, rows: 5}
    end
    f.inputs '作品照片' do
      f.has_many :works_photos, heading: false do |photo|
        photo.input :photo, label: '照片', as: :file
      end
    end
    f.submit('确定')
  end


end

