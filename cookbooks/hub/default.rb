git "tmp/hub" do
    repository "git://github.com/github/hub.git"
    user "vagrant"
end

execute "build hub" do
  command "sudo -E ./script/build"
  user "vagrant"
  cwd "tmp/hub"
end

execute "ensure ~/bin" do
  command "mkdir bin"
  not_if "test -d bin"
  user "vagrant"
end

execute "instal hub binary" do
  command "mv tmp/hub/hub bin/hub"
  not_if "test -e bin/hub"
  user "vagrant"
end

cleanup_dir "tmp/hub" do
  user "vagrant"
end
