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
    column('生日') { |child_star| (child_star.birthday.strftime("%Y-%m-%d") rescue '') }
    column('城市', :city)
    column('价格', :price)
    actions
  end

  show do

  end

  form html: {enctype: 'multipart/form-data'} do |f|
    f.inputs '作品' do
      f.input :name
      f.input :nickname
      f.input :country, as: :string
      f.input :gender
      f.input :nation
      f.input :height
      f.input :weight
      f.input :birthday, as: :datepicker
      f.input :city
      f.input :price
    end
    f.inputs '作品照片' do
      f.has_many :child_photos, heading: false do |photo|
        photo.input :photo, as: :file
      end
    end
    f.submit('确定')
  end

end
