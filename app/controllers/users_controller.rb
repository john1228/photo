class UsersController < ApplicationController
  include LoginManager

  def login
  end

  def sns
  end

  def complete
    my_params = complete_params.merge(mobile: @mobile)
    logger.info my_params.to_json
    @user = User.new(my_params)
    if @user.save
      render json: {
                 code: 1,
                 data: {
                     user: @user.detail
                 }
             }
    else
      render json: {
                 code: 0,
                 message: '完善资料出错'
             }
    end
  end

  def update
    if params.include?('password'.to_sym)
      #更新密码
      if @user.check_pwd(params[:password])
        @user.update(password: params[:new_password])
        render json: {code: 1, data: {user: @user.detail}}
      else
        render json: {code: 0, message: '更新密码失败'}
      end
    else
      #更新用户资料
      if @user.update(update_params)
        render json: {code: 1, data: {user: @user.detail}}
      else
        render json: {code: 0, message: '更新资料失败'}
      end
    end
  end

  def logout
  end

  private
  def update_params
    params.permit(:name, :avatar, :gender, :birthday, :baby_name, :baby_gender, :baby_birthday)
  end

  def complete_params
    params.permit(:name, :password)
  end
end
