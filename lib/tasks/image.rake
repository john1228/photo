namespace :image do
  desc '用户注册'
  task :fuzzy do
    current = Magick::Image.read("/usr/work/photo/public/images/viewpoint/2015/03/05/26974852-f562-41e8-a19d-c226ace587d9.jpg").first
    before = current.blur_image(0, 20)
    before.write("#{Rails.root}/1.jpg")

    after = current.blur_image(0, 20)
    gc = Magick::Draw.new
    gc.fill "black"
    gc.fill_opacity '20%'
    gc.rectangle(0, 0, before.columns, before.rows)
    gc.draw(after)
    after.write("#{Rails.root}/2.jpg")
  end
end