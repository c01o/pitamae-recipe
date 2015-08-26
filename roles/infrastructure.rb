include_recipe "../definitions.rb"
infra_packages = ["tmux", "docker", "ruby", "gem"]

infra_packages.each{|p|
  package p do
    action :install
  end
}

execute "make tmp dir" do
  command "mkdir tmp"
  not_if "test -d tmp"
  user "vagrant"
end

include_recipe "../cookbooks/zsh/default.rb"
include_recipe "../cookbooks/git/default.rb"
include_recipe "../cookbooks/golang/default.rb"
include_recipe "../cookbooks/hub/default.rb"
include_recipe "../cookbooks/vim/default.rb"

execute "delete tmp dir" do
  command "rm -rf tmp"
  only_if "test -d tmp"
end
