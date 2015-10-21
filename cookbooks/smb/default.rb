package "samba" do
  action :install
end

template "/etc/samba/smb.conf" do
  group "root"
  owner "root"
  mode "644"
end

service "samba-ad-dc" do
  action :start
end
