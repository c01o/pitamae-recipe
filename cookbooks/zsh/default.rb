package "zsh" do
  action :install
end

execute "chsh to zsh" do
  command "chsh -s `which zsh` #{node['username']}"
  not_if %Q(test `which zsh` = "$(grep #{node['username']} /etc/passwd | cut -d: -f7)")
end
