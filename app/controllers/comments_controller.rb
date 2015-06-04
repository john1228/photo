class CommentsController < ApplicationController
  before_action :verify_auth_token, only: :create

  def index
    level = params[:level]
    if level.eql?('1')||level.eql?('2')||level.eql?('3')
      comments = Comment.where(photographer_id: params[:photographer], level: params[:level].to_i).page(params[:page]||1)
    else
      comments = Comment.where(photographer_id: params[:photographer]).page(params[:page]||1)
    end
    render json: {
               code: 1,
               data: {
                   comments: comments.collect { |comment|
                     comment.detail
                   }
               }
           }
  end

  def create
    begin
      order = @user.orders.find_by(order_no: params[:no])
      comment = @user.comments.new(photographer: order.photographer, level: params[:level], pro: params[:pro],
                                   att: params[:att], pun: params[:pun], content: params[:content])
      (0..6).map { |image_index|
        comment.comment_images.new(image: params[image_index.to_s.to_sym]) if params[image_index.to_s.to_sym].present?
      }
      if comment.save
        render json: {code: 1}
      else
        render json: {code: 0, message: '评论失败'}
      end

    rescue
      render json: {code: 0, message: '评论失败'}
    end
  end

  private
  def verify_auth_token
    @user = Rails.cache.fetch(request.headers[:token])
    render json: {code: -1, message: '您还没有登录'} if @user.nil?
  end
end
