make_tmp_dir "hub"
TMP_PATH = "#{node['TMP_ROOT']}/hub"

if node['hub']
  package_name = node['hub']['package_name'] % {version: node['hub']['version'], platform: node['hub']['platform']}
  binary_url = node['hub']['binary_url'] % {version: node['hub']['version'], package_name: package_name}
  hub_installed = run_command("test -e /usr/local/hub", error: false).exit_status == 0

  unless hub_installed
    download_to_directory binary_url do
      destdir TMP_PATH
      user node['username']
    end
  end

  execute "extract hub_binary" do
    command "tar -C /usr/local/  -xvf #{package_name}"
    cwd TMP_PATH
    not_if hub_installed
  end
else
  git TMP_PATH do
    repository "git://github.com/github/hub.git"
    user node['username']
  end

  execute "build hub" do
    command "sudo -E ./script/build"
    user node['username']
    cwd TMP_PATH
  end

  execute "ensure ~/bin" do
    command "mkdir bin"
    not_if "test -d bin"
    user node['username']
  end

  execute "ensure permission of ~/bin" do
    command "chown #{node['username']}:#{node['username']} /home/#{node['username']}/bin"
    not_if "test -e bin"
    user "root"
  end

  execute "ensure permission of hub command" do
    command "chown #{node['username']}:#{node['username']} #{TMP_PATH}/bin/hub"
    not_if "test -e bin/hub"
    user "root"
  end

  execute "instal hub binary" do
    command "sudo mv #{TMP_PATH}/bin/hub bin/hub"
    not_if "test -e bin/hub"
    user node['username']
  end
end

