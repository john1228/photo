ActiveAdmin.register Banner do
  permit_params :type, :image, :url, :start_date, :end_date

  index do
    selectable_column
    column :type
    column :image
    column :url
    column :start_date
    column :end_date
    actions
  end

  show do
    attributes_table do
      row :type
      row :image
      row :url
      row :start_date
      row :end_date
    end
  end

  form html: {enctype: 'multipart/form-data'} do |f|
    f.inputs '广告' do
      f.input :type, as: :select, collection: Banner.types.keys.map { |key| [I18n.t("enums.banner.type.#{key}"), key] }, include_blank: false
      f.input :image, as: :file
      f.input :url, as: :url
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
    end
    f.submit('确定')
  end
end
