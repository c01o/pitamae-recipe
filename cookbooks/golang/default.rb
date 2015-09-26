GO_VERSION = "1.5"
GO_PACKAGE = "go#{GO_VERSION}.linux-amd64.tar.gz"
GO_BINARY_URL = "https://storage.googleapis.com/golang/#{GO_PACKAGE}"

make_tmp_dir "go"
TMP_PATH = "#{node['TMP_ROOT']}/go"

download_to_directory GO_BINARY_URL do
  destdir TMP_PATH
  user node['username']
end

execute "extract go_binary" do
  command "tar -C /usr/local -xzf #{GO_PACKAGE}"
  cwd TMP_PATH
  not_if "test -d /usr/local/go"
end

add_PATH_with_zshenv "/usr/local/go/bin"
