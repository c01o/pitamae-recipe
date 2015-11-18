%w(vim vim-gnome).each do |p|
  package p do
    action :install
  end
end

execute "install neobundle" do
  command "curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh && sh install.sh"
  user node['username']
  not_if "test -d /home/#{node['username']}/.vim/bundle"
end

git "/home/#{node['username']}/.vim/bundle/vimproc.vim" do
  repository "git://github.com/Shougo/vimproc.vim.git"
  user node['username']
end

execute "build vimproc" do
  command "make"
  user node['username']
  cwd "/home/#{node['username']}/.vim/bundle/vimproc.vim"
end

# run :NeoBundleInstall automatically after .vimrc placed
execute "install vim plugins" do
  command %Q(vim -u ~/.vimrc -i NONE -c "try | NeoBundleUpdate! | finally | q! | endtry" -e -s -V1 -V9neobundle.log)
  user node['username']
end

# activate vim-migemo
include_recipe "../cmigemo/default.rb"
