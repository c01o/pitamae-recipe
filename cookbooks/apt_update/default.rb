execute "refresh apt repo" do
  command "apt-get update"
  user "root"
end

execute "install new softwares" do
  command "apt-get upgrade -y"
  user "root"
end

execute "install new kernel files" do
  command "apt-get dist-upgrade -y"
  user "root"
end

execute "remove obsolete files" do
  command "apt-get autoclean -y && apt-get autoremove -y"
  user "root"
end
