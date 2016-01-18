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
      Rails.cache.write(@user.token, @user)
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
    #更新用户资料
    if @user.update(update_params)
      render json: {code: 1, data: {user: @user.detail}}
    else
      render json: {code: 0, message: '更新失败'+ @user.errors.messages.values.join(';')}
    end
  end

  def logout
  end

  private
  def update_params
    params.permit(:name, :password, :avatar, :gender, :birthday, :baby_name, :baby_gender, :baby_birthday)
  end

  def complete_params
    params.permit(:name, :password)
  end
end
