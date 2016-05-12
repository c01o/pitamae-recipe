require 'unix_crypt'

user node['username'] do
  action :create
  password UnixCrypt::SHA512.build(node['password'], node['salt'])
end

# 後からsudoに追加
add_user_to_group node['username'] do
  group "sudo"
end

# raspbianならpiユーザと同等グループを付与
if node['platform'] == "raspbian"
  %w(pi adm dialout cdrom audio video plugdev games users input netdev spi i2c gpio).each do |g|
    add_user_to_group node['username'] do
      group g
    end
  end
end


directory "/home/#{node['username']}" do
  action :create
  owner node['username']
  group node['username']
end

