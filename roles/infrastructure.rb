# script settings
include_recipe "../definitions.rb"
# machine settings
include_recipe "./makeuser.rb"
include_recipe "./enable_sudoPATH.rb"
include_recipe "./apt_update.rb"
# user settings
include_recipe "../cookbooks/zsh/default.rb"

# individual packages

INFRA_PACKAGES = ["tmux", "docker", "ruby", "gem"]
TMP_ROOT = "/var/tmp/pitamae"

INFRA_PACKAGES.each{|p|
  package p do
    action :install
  end
}

make_tmp_dir TMP_ROOT do
  root_flag true
end

include_recipe "../cookbooks/git/default.rb"
include_recipe "../cookbooks/bundler/default.rb"
include_recipe "../cookbooks/golang/default.rb"
include_recipe "../cookbooks/hub/default.rb"
include_recipe "../cookbooks/vim/default.rb"
include_recipe "../cookbooks/dotfiles/default.rb"

cleanup_dir TMP_ROOT
