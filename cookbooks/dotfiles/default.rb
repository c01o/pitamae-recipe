git "/home/#{node['username']}/dotfiles" do
  repository "git://github.com/c01o/dotfiles.git"
  user node['username']
end

execute "make symlinks to dotfiles in repo" do
  command "yes | /home/#{node['username']}/dotfiles/initfiles.sh"
  user node['username']
end
