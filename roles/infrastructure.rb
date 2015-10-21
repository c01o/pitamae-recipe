# script settings
include_recipe "../definitions.rb"

# machine settings
include_recipe "../cookbooks/make_user/default.rb"
include_recipe "../cookbooks/enable_sudoPATH/default.rb"
include_recipe "../cookbooks/apt_update/default.rb"
include_recipe "../cookbooks/generate_locale/default.rb"

# user settings
include_recipe "../cookbooks/git/default.rb"
include_recipe "../cookbooks/dotfiles/default.rb"
include_recipe "../cookbooks/zsh/default.rb"

# individual packages
TMP_ROOT = node['TMP_ROOT']

INFRA_PACKAGES = ["curl", "tmux", "docker", "ruby", "gem", "build-essential"]
INFRA_PACKAGES.each{|p|
  package p do
    action :install
  end
}

make_tmp_dir TMP_ROOT do
  root_flag true
end

include_recipe "../cookbooks/bundler/default.rb"
include_recipe "../cookbooks/golang/default.rb"
include_recipe "../cookbooks/hub/default.rb"
include_recipe "../cookbooks/vim/default.rb"

# optional settings
include_recipe "../cookbooks/wlan/default.rb"

cleanup_dir TMP_ROOT
