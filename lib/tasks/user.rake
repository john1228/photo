namespace :users do
  desc '用户注册'
  task :login do
    host = "http://192.168.0.126"
    conn = Faraday.new(:url => host)
    response = conn.post "users/login", username: '13916518973', password: '123456'
    puts response.body
  end
  task :sns do
    host = "http://localhost"
    conn = Faraday.new(:url => host)
    response = conn.post "users/sns", mobile: '18516691251'
    puts response.body
  end
  task :complete do
    host = "http://localhost"
    conn = Faraday.new(:url => host)
    conn.headers['token'] = '089879516e3f3c1a15a28719121b754e'
    response = conn.post "users/complete", name: '测试用户', password: '123456'
    puts response.body
  end
  task :update do
    host = "http://192.168.0.126"
    conn = Faraday.new(:url => host)
    conn.headers['token'] = '643fb4ded8fcd63e8114d2b577dac800'
    response = conn.put "users", name: 'sb8701'
    puts response.body
  end
  task :logout do
    host = "http://localhost"
    conn = Faraday.new(:url => host)
    conn.headers['token'] = '643fb4ded8fcd63e8114d2b577dac800'
    response = conn.post "/captcha/check", captcha: '825163'
    puts response.body
  end
end