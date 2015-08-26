package "zsh" do
  action :install
end

execute "chsh to zsh" do
  command "chsh -s `which zsh` vagrant"
  not_if 'test `which zsh` = "$(grep vagrant /etc/passwd | cut -d: -f7)"'
end

execute "assertion" do
  command "test `which zsh` = `echo $SHELL`"
end
