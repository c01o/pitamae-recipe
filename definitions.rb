TMP_ROOT = node['TMP_ROOT']

# params絡み、一旦変数経由しないとundefined method or variable言われる。なんでだ？
define :download_to_directory, destdir: nil do
  def get_filename(url)
    url =~ /([^\/]+?)([\?#].*)?$/
    $&
  end

  url = params[:name]
  destdir = params[:destdir]
  filename = get_filename(url)

  execute "ensure destdir" do
    command "mkdir -p #{destdir}" 
    not_if "test -d #{destdir}"
  end

  execute "download #{url} to #{destdir}" do
    command "curl -Ls #{url} -O"
    cwd destdir
    not_if "test -e #{filename}"
  end
end

define :add_PATH_with_zshenv do
  path = params[:name]

  execute "add export PATH to zshrc" do
    command %Q(echo 'export PATH="#{path}:$PATH"' >> .zshenv)
    not_if "cat .zshenv | grep '#{path}:$PATH'"
    user node['username']
  end

  # $ZSH_VERSIONが半角スペース = zsh以外で実行中 と判定
  execute "reload zshenv" do
    command "source .zshenv"
    user node['username']
    not_if %Q( test `echo $ZSH_VERSION` =  )
  end

  execute "if not being runned on zsh" do
    command %Q(echo "not running on zsh! so the shell might not read .zshenv")
    user node['username']
    only_if %Q( test `echo $ZSH_VERSION` =  )
  end
end

# sample snippet
#
# make_tmp_dir "package_name"
# TMP_PATH = "#{node['TMP_ROOT']}/package_name"
# もっとマシなやり方があるはず…
define :make_tmp_dir, root_flag: nil do
  dirname = params[:name]
  dirpath = params[:root_flag] ? TMP_ROOT : "#{TMP_ROOT}/#{dirname}"

  directory dirpath do
    action :create
    user node['username']
    not_if "test -d #{dirpath}"
  end
end

define :cleanup_dir do
  path = params[:name] 

  execute "cleanup" do
    command "rm -rf #{path}"
    only_if "test -d #{path}"
  end
end

define :add_user_to_group, group: nil do
  username = params[:name]
  groupname = params[:group]

  execute "add #{username} to group #{groupname}" do
    command "gpasswd -a #{username} #{groupname}"
    user "root"
  end
end
