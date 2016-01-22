class Works < ActiveRecord::Base
  belongs_to :photographer
  has_many :works_photos, dependent: :destroy
  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :works_photos, reject_if: :all_blank, allow_destroy: true

  TYPE = %W"外景 内景 上门 跟拍"
  AGE = %W"满月 百日 一岁 三岁以上"
  RCD = 3 #推荐
  POP = 2 #人气
  CPL = 1 #综合
  class<<self
    def category(category='comp')
      case category
        when 'comp' #综合排行
          where("1=1")
        when 'pop' #人气排行
          where("1=1")
        when 'rcm' #推荐排行
          where("1=1")
        else
      end
    end
  end

  def detail
    {
        info: {
            id: id,
            title: title,
            type: works_type,
            price: price,
            discount: discount,
            during: during,
            intro: intro,
            photos: works_photos.collect { |photo| photo.detail }
        },
        photographer: photographer.detail,
        photographed: orders.where(status: [Order.statuses[:complete], Order::STATUS[:done]], works_id: id).count
    }
  end
end
