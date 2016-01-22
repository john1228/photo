class Banner < ActiveRecord::Base
  self.inheritance_column = false
  enum type: [:home, :child]

  mount_uploader :image, BannerUploader
end
