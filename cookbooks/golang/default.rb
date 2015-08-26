GO_VERSION = "1.5"
GO_PACKAGE = "go#{GO_VERSION}.linux-amd64.tar.gz"
GO_BINARY_URL = "https://storage.googleapis.com/golang/#{GO_PACKAGE}"

download_to_directory GO_BINARY_URL do
  destdir "tmp/go"
  user "vagrant"
end

execute "extract go_binary" do
  command "tar -C /usr/local -xzf #{GO_PACKAGE}"
  cwd "tmp/go"
end

add_PATH_with_zshenv "/usr/local/go/bin"
