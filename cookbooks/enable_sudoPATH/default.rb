remote_file "/var/tmp/enable_sudoPATH.sh" do
  owner "root"
  group "root"
  mode "777"
  source "../../scripts/enable_sudoPATH.sh"
end

execute "enable sudo $PATH for group itamae with visudo" do
  command "/bin/sh /var/tmp/enable_sudoPATH.sh"
  user "root"
end

execute "cleanup" do
  command "rm /var/tmp/enable_sudoPATH.sh"
  user "root"
end

group "itamae" do
  action :create
end

add_user_to_group node['username'] do
  group "itamae"
end
