user node['username'] do
  action :create
  password node['password']
end

# 後からsudoに追加
user node['username'] do
  gid "sudo"
end

directory "/home/#{node['username']}" do
  action :create
  owner node['username']
end

