make_tmp_dir "hub"
TMP_PATH = "/var/tmp/pitamae/hub"

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

execute "instal hub binary" do
  command "mv #{TMP_PATH}/hub bin/hub"
  not_if "test -e bin/hub"
  user node['username']
end
