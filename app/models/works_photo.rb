class WorksPhoto < ActiveRecord::Base
  belongs_to :works, class: Works

  mount_uploader :photo, WorksPhotoUploader

  def detail
    {
        photo: photo.thumb.url,
        height: photo_height
    }
  end
end
