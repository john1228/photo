module LoginManager
  extend ActiveSupport::Concern
  included do
    before_action :verify_password, only: :login
    before_action :verify_sns, only: :sns
    before_action :remove_cache, only: :destroy
    before_action :verify_auth_token, only: :update
    before_action :fetch_mobile, only: :complete
  end

  private
  def verify_password
    user = User.find_by(mobile: params[:username])
    if user.nil?
      render json: {code: 0, message: '您还没有注册'}
    else
      if user.check_pwd(params[:password])
        Rails.cache.write(user.token, user)
        render json: {
                   code: 1,
                   data: {
                       user: user.detail
                   }
               }
      else
        logger.info '密码不正确'
        render json: {
                   code: 0,
                   message: '您输入到密码不正确'
               }
      end
    end
  end

  def verify_sns
    @user = User.find_by(sns: "#{params[:sns_name]}_#{params[:sns_id]}")
    if @user.nil?
      if params[:sns_name].eql?('weixin')
        avatar_array = params[:avatar].split('/')
        avatar_array.last
      end
      @user = User.create(
          sns: "#{params[:sns_name]}_#{params[:sns_id]}",
          name: params[:name],
          avatar: params[:avatar],
          gender: params[:gender],
          birthday: params[:birthday]
      )
    end
    Rails.cache.write(@user.token, @user)
    render json: {
               code: 1,
               data: {
                   user: @user.detail
               }
           }
  end

  def remove_cache
    Rails.cache.delete(request.headers[:token])
  end

  def verify_auth_token
    logger.info "用户TOKEN#{request.headers[:token]}"
    @user = Rails.cache.fetch(request.headers[:token])
    render json: {code: 0, message: '您还没有登录'} if @user.nil?
  end

  def fetch_mobile
    @mobile = Rails.cache.fetch(request.headers[:token])
    render json: {code: 0, message: '信息已过期，请重新发送验证码'} if @mobile.nil?
  end
end