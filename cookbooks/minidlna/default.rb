package "minidlna" do
  action :install
end

template "/etc/minidlna.conf" do
  group "root"
  owner "root"
  mode "644"
end

service "minidlna" do
  action :start
end
