class ChildPhoto < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
end
