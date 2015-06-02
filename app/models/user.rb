class User < ActiveRecord::Base
  validates_uniqueness_of :mobile, message: '该手机号已经被注册或绑定'
  before_save :build_password
  mount_uploader :avatar, UserAvatarUploader


  #has_many :coupons
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :babies, dependent: :destroy
  has_many :orders, dependent: :destroy
  attr_accessor :remote_icon_url

  def token
    Digest::MD5.hexdigest("#{id}|#{salt}")
  end

  def check_pwd(pwd)
    password.eql?(Digest::MD5.hexdigest("#{pwd}|#{salt}"))
  end

  def age
    birth = birthday||Date.today.prev_year(15)
    years = Date.today.year - birth.year
    years + (Date.today < birth + years.year ? -1 : 0)
  end

  def summary
    {
        name: name,
        avatar: avatar.thumb.url,
    }
  end

  def detail
    base = {
        token: token,
        name: name,
        avatar: avatar.thumb.url,
        gender: gender||0,
        birthday: (birthday||Date.today.prev_year(15)).strftime('%Y-%m-%d'),
        age: age,
        mobile: mobile.nil? ? '' : mobile,
        sns: sns||''
    }
    base.merge(baby: {name: baby_name, gender: baby_gender, birthday: baby_birthday}) unless baby_name.nil?
    base
  end

  private
  def build_password
    if password.blank?||password.length != 32
      salt_arr = %w"a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9"
      self.salt = salt_arr.sample(18).join
      self.password = Digest::MD5.hexdigest("#{password}|#{self.salt}")
    end
  end
end
