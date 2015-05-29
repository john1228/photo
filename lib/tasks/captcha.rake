namespace :captcha do
  desc '用户注册'
  task :regist do
    host = "http://localhost"
    conn = Faraday.new(:url => host)
    response = conn.post "/captcha/regist", mobile: '18516691251'
    puts response.body
  end
  task :change do
    host = "http://localhost"
    conn = Faraday.new(:url => host)
    response = conn.post "/captcha/change", mobile: '18516691251'
    puts response.body
  end
  task :binding do
    host = "http://localhost"
    conn = Faraday.new(:url => host)
    response = conn.post "/captcha/binding", mobile: '18516691251'
    puts response.body
  end
  task :check do
    host = "http://localhost"
    conn = Faraday.new(:url => host)
    conn.headers['token'] = '643fb4ded8fcd63e8114d2b577dac800'
    response = conn.post "/captcha/check", captcha: '475609'
    puts response.body
  end
end