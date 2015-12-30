make_tmp_dir "go"
TMP_PATH = "#{node['TMP_ROOT']}/go"

if node['golang']
  package_name = node['golang']['package_name'] % {version: node['golang']['version'], platform: node['golang']['platform']}
  binary_url = node['golang']['binary_url'] % {package_name: package_name}
  go_installed = run_command("test -d /usr/local/go", error: false).exit_status == 0

  unless go_installed
    download_to_directory binary_url do
      destdir TMP_PATH
      user node['username']
    end
  end

  execute "extract go_binary" do
    command "tar -C /usr/local -xzf #{package_name}"
    cwd TMP_PATH
    not_if go_installed
  end

  add_PATH_with_zshenv "/usr/local/go/bin"
else
  package "golang" do
    action :install
  end
end
