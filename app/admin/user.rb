ActiveAdmin.register User do
  menu label: '用户'

  filter :name, lable: '姓名'
  permit_params :name

  index do
    selectable_column
    column('姓名') { |user| link_to(user.name, admin_user_path(user)) }
    column('头像') { |user| image_tag(user.avatar.thumb.url) }
    column('性别') { |user| user.gender.eql?(1) ? '女' : '男' }
    column('生日') { |user| (user.birthday.strftime('%Y-%m-%d') rescue '') }
    column('绑定手机', :mobile)
    column('注册日期') { |user| user.created_at.strftime('%Y-%m-%d %H:%M:%S') }
  end

  show do
    tabs do
      tab '0-宝贝儿信息' do
        columns do
          for baby in user.babies
            column do
              panel "宝贝儿-#{baby.name}" do
                attributes_table_for baby do
                  row('性别') { |baby_info|
                    baby_info.gender.eql?(1) ? '女' : '男'
                  }
                  row('生日') { |baby_info| baby_info.birthday.strftime('%Y-%m-%d') }
                end
              end
            end
          end
        end
      end
    end
  end

  sidebar '用户信息', only: :show do
    attributes_table_for user do
      row('姓名') { |user| user.name }
      row('头像') { |user| image_tag(user.avatar.thumb.url) }
    end
  end
end
