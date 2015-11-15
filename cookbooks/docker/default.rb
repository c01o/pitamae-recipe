case node['platform']
when "raspbian" then
  make_tmp_dir "docker"
  TMP_PATH = "#{node['TMP_ROOT']}/docker"

  download_to_directory "http://downloads.hypriot.com/docker-hypriot_1.9.0-2_armhf.deb" do
    destdir TMP_PATH
  end

  execute "install docker" do
    command "dpkg -i -GE docker-hypriot_1.9.0-2_armhf.deb"
    cwd TMP_PATH
  end
else
  package "docker.io" do
    action :install
  end
end
