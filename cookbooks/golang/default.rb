make_tmp_dir "go"
TMP_PATH = "#{node['TMP_ROOT']}/go"

package_name = node['golang']['package_name'] % {version: node['golang']['version'], platform: node['golang']['platform']}
binary_url = node['golang']['binary_url'] % {package_name: package_name}

download_to_directory binary_url do
  destdir TMP_PATH
  user node['username']
  not_if "test -d /usr/local/go"
end

execute "extract go_binary" do
  command "tar -C /usr/local -xzf #{package_name}"
  cwd TMP_PATH
  not_if "test -d /usr/local/go"
end

add_PATH_with_zshenv "/usr/local/go/bin"
