class Comment < ActiveRecord::Base
  after_create
  belongs_to :photographer
  has_many :comment_images, dependent: :destroy
  belongs_to :user

  attr_accessor :images

  def detail
    {
        id: id,
        content: content,
        images: comment_images.collect { |comment_image| comment_image.image.thumb.url }
    }
  end

  private
  def save_images
    images.map { |image|
      comment_images.create(image: image)
    }
  end
end
