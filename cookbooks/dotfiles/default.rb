git "/home/vagrant/dotfiles" do
  repository "git://github.com/c01o/dotfiles.git"
  user "vagrant"
end

execute "make symlinks to dotfiles in repo" do
  command "yes | /home/vagrant/dotfiles/initfiles.sh"
  user "vagrant"
end
