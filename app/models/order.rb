class Order < ActiveRecord::Base
  before_create :build_default
  belongs_to :user
  belongs_to :photographer
  belongs_to :works, class: Works
  enum status: [:unpaid, :pay, :done, :complete, :deleted]

  def detail
    {
        no: order_no,
        works: works.detail,
        appoint: {
            date: appoint_date,
            time: appoint_time,
            address: appoint_address
        },
        contact: contact,
        phone: phone,
        baby: {
            name: baby_name,
            gender: baby_gender,
            birthday: baby_birthday
        },
        coupons: coupons||'',
        price: price,
        status: Order.statuses[status],
        progress: progress?,
        created: created_at.to_i
    }
  end

  def progress?
    if appoint_date.eql?(Date.today)
      hour = Time.now.hour
      if appoint_time.eql?(0)
        if 9<hour && hour<12
          1
        else
          0
        end
      else
        if 13<hour && hour<18
          1
        else
          0
        end
      end
    else
      0
    end
  end

  def status_name
    case status
      when STATUS[:unpay]
        '未支付'
      when STATUS[:pay]
        '已付款'
      when STATUS[:done]
        '已完成'
      when STATUS[:complete]
        '已评价'
      when STATUS[:delete]
        '已取消'
      else
        '错误到状态'
    end
  end

  private
  def build_default
    self.order_no = Time.now.strftime('%Y%m%d%H%M%S%L')+('%03d' % rand(100))
    self.status = STATUS[:unpay]
  end
end
