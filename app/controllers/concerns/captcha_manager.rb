module CaptchaManager
  extend ActiveSupport::Concern

  included do
    before_action :verify_token, only: :binding
    before_action :verify_captcha, only: :check
  end

  private
  def send_sms(mobile)
    conn = Faraday.new(url: 'https://sandboxapp.cloopen.com:8883')
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    account = 'aaf98f894b0b8616014b19c5e46709c3'
    account_token = '6212e011d5634ff896a9a179c313c217'
    appid = 'aaf98f894b0b8616014b19c7261f09cd'
    templateid = '12107'
    captcha = %w"0 1 2 3 4 5 6 7 8 9".sample(6).join('')
    auth = Base64.strict_encode64(account + ":" + timestamp)
    sig = Digest::MD5.hexdigest(account + account_token + timestamp)

    conn.headers['Accept'] = 'application/json'
    conn.headers['Authorization'] = auth
    conn.headers['Content-Type'] = 'application/json;charset=utf-8'
    params = {to: "#{mobile}", appId: appid, templateId: templateid, datas: ["#{captcha}", '30'], data: ''}
    conn.post "/2013-12-26/Accounts/#{account}/SMS/TemplateSMS?sig=#{sig}", params.to_json

    token = Digest::MD5.hexdigest(mobile)
    if request[:action].eql?('binding')
      Rails.cache.write(token, {mobile: mobile, captcha: captcha, action: request[:action], user_token: request.headers[:token]}, expires_in: 30.minutes)
    else
      Rails.cache.write(token, {mobile: mobile, captcha: captcha, action: request[:action]}, expires_in: 30.minutes)
    end
    token
  end

  def verify_token
    @user = Rails.cache.fetch(request.headers[:token])
    render json: {code: -1, message: '您还没有登录'} if @user.nil?
  end

  def verify_captcha
    cache_info = Rails.cache.fetch(request.headers[:token])
    if cache_info.blank?
      render json: {code: 0, message: '验证码已过期'}
    else
      action = cache_info[:action]
      mobile = cache_info[:mobile]
      captcha = cache_info[:captcha]
      if captcha.eql?(params[:captcha])||true
        case action
          when 'regist'
            new_token = Digest::MD5.hexdigest("#{mobile}||#{rand(100)}")
            Rails.cache.write(new_token, mobile, expires_in: 30.minutes)
            render json: {code: 1, data: {token: new_token}}
          when 'change'
            user = User.find_by(mobile: mobile)
            if user.update(password: params[:password])
              Rails.cache.write(user.token, user)
              render json: {code: 1, data: {user: user.detail}}
            else
              render json: {code: 0, message: '设置密码错误'}
            end
          when 'binding'
            user = Rails.cache.fetch(cache_info[:user_token])
            if user.update(mobile: mobile)
              Rails.cache.write(cache_info[:user_token], user.reload)
              render json: {code: 1, data: {user: user.detail}}
            else
              render json: {code: 0, message: '绑定手机号错误'}
            end
          else
            render json: {code: 0, message: '错误的参数'}
        end
      else
        render json: {code: 0, message: '验证码不正确'}
      end
    end
    Rails.cache.delete(request.headers[:token])
  end
end