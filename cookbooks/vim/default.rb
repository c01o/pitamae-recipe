package "vim" do
  action :install
end

# run :NeoBundleInstall automatically after .vimrc placed
execute "install vim plugins" do
  command %Q(vim -u ~/.vimrc -i NONE -c "try | NeoBundleUpdate! | finally | q! | endtry" -e -s -V1 -V9neobundle.log)
  user node['username']
end
