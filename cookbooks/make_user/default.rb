require 'unix_crypt'

user node['username'] do
  action :create
  password UnixCrypt::SHA512.build(node['password'], node['salt'])
end

# 後からsudoに追加
user node['username'] do
  gid "sudo"
end

directory "/home/#{node['username']}" do
  action :create
  owner node['username']
end

