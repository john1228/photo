class CaptchaController < ApplicationController
  include CaptchaManager

  def regist
    user = User.find_by(mobile: params[:mobile])
    if user.nil?
      token = send_sms(params[:mobile])
      render json: {code: 1, data: {token: token}}
    else
      render json: {code: 0, message: '该号码已注册或已绑定'}
    end
  end

  def change
    user = User.find_by(mobile: params[:mobile])
    if user.nil?
      render json: {code: 0, message: '该号码还未注册或者绑定'}
    else
      token = send_sms(params[:mobile])
      render json: {code: 1, data: {token: token}}
    end
  end


  def binding
    user = User.find_by(mobile: params[:mobile])
    if user.nil?
      render json: {code: 0, message: '该号码已绑定'}
    else
      token = send_sms(params[:mobile])
      render json: {code: 1, data: {token: token}}
    end
  end


  def check
  end
end
