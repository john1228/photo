class Comment < ActiveRecord::Base
  belongs_to :photographer
  has_many :comment_images, dependent: :destroy
  belongs_to :user

  def detail
    {
        id: id,
        content: content,
        images: comment_images.collect { |comment_image| comment_image.image.thumb.url },
        user: user.summary,
        created: created_at.to_i
    }
  end
end
