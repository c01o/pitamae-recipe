package "vim" do
  action :install
end

# run :NeoBundleInstall automatically after .vimrc placed
execute "install vim plugins" do
  command "vim +\":NeoBundleInstall\" +:q"
  user "vagrant"
end
