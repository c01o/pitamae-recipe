define :download_to_directory, destdir: nil do
  def get_filename(url)
    url =~ /([^\/]+?)([\?#].*)?$/
    $&
  end

  url = params[:name]
  destdir = params[:destdir]
  filename = get_filename(url)
  execute "debug: p filename" do
    command "echo #{filename}"
  end

  execute "ensure_destdir" do
    command "mkdir -p #{destdir}" 
    not_if "test -d #{destdir}"
  end

  execute "download" do
    command "curl -s #{url} -O"
    cwd destdir
    not_if "test -e #{filename}"
  end
end

define :cleanup_dir do
  name = params[:name] # <-変数経由しないとundefined method or variable言われる。なんでだ？
  execute "cleanup" do
    command "rm -rf #{name}"
  end
end

define :add_PATH_with_zshenv do
  path = params[:name]

  execute "add export PATH to zshrc" do
    command %Q(echo 'export PATH="#{path}:$PATH"' >> .zshenv)
    not_if "cat .zshenv | grep '#{path}:$PATH'"
  end

  execute "reload zshenv" do
    command "source .zshenv"
    user "vagrant"
  end
end

define :make_tmp_dir do
  dirname = params[:name]

  directory "/var/tmp/pitamae/#{dirname}" do
    action :create
  end
end

# sample snippet
#
# make_tmp_dir "package_name"
# TMP_PATH = "/var/tmp/pitamae/package_name"
# もっとマシなやり方があるはず…

