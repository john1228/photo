ActiveAdmin.register ChildStar do
  menu label: '童星'

  permit_params :name, :nickname, :country, :gender, :nation, :height, :weight, :birthday, :city, :price,
                child_photos_attributes: [:id, :photo]

  index do
    selectable_column
    column('名字', :name)
    column('昵称', :nickname)
    column('国家', :country)
    column('性别', :gender)
    column('民族', :nation)
    column('身高', :height)
    column('体重', :weight)
    column('生日') { |child_star| child_star.birthday.strftime("%Y-%m-%d") }
    column('城市', :city)
    column('价格', :price)
    actions
  end

  show do

  end

  form html: {enctype: 'multipart/form-data'} do |f|
    f.inputs '作品' do
      f.input :name, label: '名称'
      f.input :nickname, label: '昵称'
      f.input :country, label: '国家', as: :string
      f.input :gender, label: '性别'
      f.input :nation, label: '民族'
      f.input :height, label: '身高'
      f.input :weight, label: '体重'
      f.input :birthday, label: '生日', as: :string
      f.input :city, label: '城市'
      f.input :price, label: '价格'
    end
    f.inputs '作品照片' do
      f.has_many :child_photos, heading: false do |photo|
        photo.input :photo, label: '照片', as: :file
      end
    end
    f.submit('确定')
  end

end
