namespace :orders do
  desc '用户注册'
  task :index do
    host = "http://192.168.0.126"
    conn = Faraday.new(:url => host)
    conn.headers['token'] = 'e4da3b7fbbce2345d7772b0674a318d5'
    response = conn.get "orders"
    puts response.body
  end
  task :create do
    host = "http://192.168.0.126  "
    conn = Faraday.new(:url => host)
    conn.headers['token'] = 'e4da3b7fbbce2345d7772b0674a318d5'
    response = conn.post "orders", id: 1, date: Date.today.next_day(3), time: 0,
                         address: '中山西路933号', contact: 'john', phone: '13916518973',
                         name: '宝儿', gender: 1, birthday: Date.today.next_month(2)
    puts response.body
  end
end