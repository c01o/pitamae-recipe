package "avahi-daemon" do
  action :install
end

remote_file "/etc/avahi/services/smb.service" do
  action :create
end
