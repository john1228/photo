class Photographer < ActiveRecord::Base
  mount_uploader :avatar, PhotographerAvatarUploader

  has_many :works, class: Works, dependent: :destroy
  has_many :comments
  has_many :orders

  class << self
    def category(category)
      case category
        when 'comp' #综合排行
          where("1=1")
        when 'pop' #人气排行
          where("1=1")
        when 'rcm' #推荐排行
          where("1=1")
        else
          where('1=1')
      end
    end
  end

  def detail
    {
        id: id,
        name: name,
        avatar: avatar.thumb.url,
        level: level,
        price: price,
        city: city,
        photos: orders.where(status: [Order.statuses[:complete], Order.statuses[:done]]).count,
        score: {
            com: (comments.average('(pro+att+pun)').to_f).round(1),
            detail: {
                pro: (comments.average(:pro).to_f).round(1),
                att: (comments.average(:att).to_f).round(1),
                pun: (comments.average(:pun).to_f).round(1)
            }
        },
        comments: {
            l1: comments.where(level: 1),
            l2: comments.where(level: 2),
            l3: comments.where(level: 3)
        }
    }
  end

  def appointments
    appoint_info = {}
    orders.select(:appoint_date, :appoint_time).where('appoint_date>?', Date.today).map { |order|
      if appoint_info.include?(order.appoint_date.to_s)
        appoint_info[order.appoint_date.to_s] = 2
      else
        appoint_info[order.appoint_date.to_s] = order.appoint_time
      end
    }
    appoint_info.map { |k, v| {date: k, time: v} }
  end
end
