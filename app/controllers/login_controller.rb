class LoginController < ApplicationController
  def sns
    user = sns_login(params[:sns], params[:code])
    if user.blank?
      render json: Failure.new('第三方登录失败')
    else
      Rails.cache.write(user.token, user)
      render json: {
                 code: 1,
                 data: {
                     user: user.detail
                 }
             }
    end
  end

  private
  def sns_login(sns, code)
    case sns
      when 'qq'
        oauth_consumer_key = '1104792015'
        host = 'https://graph.qq.com/'
        conn = Faraday.new(:url => host)
        #获取ME
        me = conn.get 'oauth2.0/me', access_token: code
        me_json = JSON.parse(me.body.gsub('callback( ', '').gsub(');', ''))
        openid = me_json['openid']
        #获取用户信息
        userinfo_response = conn.get 'user/get_user_info ', access_token: code, oauth_consumer_key: oauth_consumer_key, openid: openid
        user_info = JSON.parse(userinfo_response.body)
        sns_key = "QQ_#{openid}"
        user = User.find_by(sns: sns_key)
        if user.nil?
          user = User.create(
              mobile: SecureRandom.uuid,
              sns: sns_key,
              name: user_info['nickname'],
              avatar: user_info['headimgurl'],
              gender: user_info['sex'].eql?('1') ? 0 : 1,
          )
        end
        user
      when 'weixin'
        appid = 'wx30591704a611e1fc'
        secret = 'd4624c36b6795d1d99dcf0547af5443d'
        grant_type = 'authorization_code'
        host = 'https://api.weixin.qq.com'
        conn = Faraday.new(:url => host)
        access_response = conn.get 'sns/oauth2/access_token', appid: appid, secret: secret, code: code, grant_type: grant_type
        access_token = JSON.parse(access_response.body)['access_token']
        #TO: 获取用户信息
        userinfo_response = conn.get 'sns/userinfo', access_token: access_token, openid: appid
        user_info = JSON.parse(userinfo_response.body)
        logger.info user_info
        sns_key = "WeChat_#{user_info['openid']}"
        user = User.find_by(sns: sns_key)
        if user.nil?
          user = User.create(
              mobile: SecureRandom.uuid,
              sns: sns_key,
              name: user_info['nickname'],
              avatar: user_info['headimgurl'],
              gender: user_info['sex'].eql?('1') ? 0 : 1,
          )
        end
        user
      when 'sina'
        #获取UID
        host = 'https://api.weibo.com'
        conn = Faraday.new(:url => host)
        response = conn.get '2/account/get_uid.json', access_token: code
        uid_json = JSON.parse(response.body)
        #TO: 获取用户信息
        userinfo_response = conn.get '2/users/show.json', access_token: code, uid: uid_json['uid']
        user_info = JSON.parse(userinfo_response.body)
        sns_key = "sina_#{user_info['id']}"
        user = User.find_by(sns: sns_key)
        if user.nil?
          user = User.create(
              mobile: SecureRandom.uuid,
              sns: sns_key,
              name: user_info['nickname'],
              avatar: user_info['headimgurl'],
              gender: user_info['sex'].eql?('1') ? 0 : 1,
          )
        end
        user
      else
    end
  end
end