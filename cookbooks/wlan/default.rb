package "wpasupplicant" do
  action :install
end

execute "create template of wpa_supplicant.conf" do
  command "wpa_passphrase #{node['wlan']['SSID']} #{node['wlan']['psk']} > /etc/wpa_supplicant/wpa_supplicant.conf" 
  not_if "test -e /etc/wpa_supplicant/wpa_supplicant.conf"
end

wpa_add_content = <<EOS
network={
        proto=WPA WPA2
        key_mgmt=WPA-PSK
        pairwise=CCMP TKIP
        group=CCMP TKIP
        priority=2
EOS

file "/etc/wpa_supplicant/wpa_supplicant.conf" do
  action :edit
  block do |content|
    content.gsub!(/^network={/, wpa_add_content)
  end
  mode "600"
  not_if "grep \"#{wpa_add_content}\" /etc/wpa_supplicant/wpa_supplicant.conf"
end

iface_add_content = <<EOS
auto wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
EOS

execute "interfaces settings" do
  command "echo \"#{iface_add_content}\" >> /etc/network/interfaces"
end
