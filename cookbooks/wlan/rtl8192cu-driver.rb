make_tmp_dir "rtl8192cu-driver"
TMP_PATH = "#{node['TMP_ROOT']}/rtl8192cu-driver"

["git", "linux-headers-generic", "build-essential", "dkms"].each do |p|
  package p do
    action :install
  end
end

git TMP_PATH do
    repository "git://github.com/pvaret/rtl8192cu-fixes.git"
    user node['username']
end

execute "compile driver" do
  command "sudo dkms add ./rtl8192cu-fixes && sudo dkms install 8192cu/1.10 && sudo depmod -a && sudo cp ./rtl8192cu-fixes/blacklist-native-rtl8192.conf /etc/modprobe.d/"
  cwd TMP_PATH
  not_if "test -e /etc/modprobe.d/blacklist-native-rtl8192.conf"
end
