class ChildStar < ActiveRecord::Base
  has_many :child_photos, dependent: :destroy
  after_create :save_photos
  accepts_nested_attributes_for :child_photos, reject_if: :all_blank, allow_destroy: true
  attr_accessor :p1, :p2, :p3
  CATEGORY = %W"0-1岁男孩 1-3岁男孩 3-6岁男孩 6岁以上男孩 0-1岁女孩 0-3岁女孩 3-6岁女孩 6岁以上女孩"

  def detail
    {
        id: id,
        name: name,
        nickname: nickname,
        country: country,
        gender: gender,
        nation: nation,
        height: height,
        weight: weight,
        birthday: birthday,
        city: city,
        price: price,
        photos: child_photos.collect { |photo| photo.photo.thumb.url },
        likes: 0
    }
  end

  private
  def save_photos
    child_photos.create(photo: p1) unless p1.blank?
    child_photos.create(photo: p2) unless p2.blank?
    child_photos.create(photo: p3) unless p3.blank?
  end
end
