# script settings
include_recipe "../definitions.rb"

# なぜかリモートで走らせた時だけそんなppaねえって言われる
#ppas = ["cpick/hub"]
#ppas.each {|p|
#  execute "add ppa" do
#    command "sudo add-apt-repository ppa:#{p} -y"
#  end
#}

# machine settings
include_recipe "../cookbooks/apt_update/default.rb"
include_recipe "../cookbooks/generate_locale/default.rb"

# user settings
include_recipe "../cookbooks/git/default.rb"
include_recipe "../cookbooks/dotfiles/default.rb"
include_recipe "../cookbooks/zsh/default.rb"

# individual packages
TMP_ROOT = node['TMP_ROOT']

INFRA_PACKAGES = ["curl", "tmux", "ruby", "gem", "build-essential", "hub"]
INFRA_PACKAGES.each{|p|
  package p do
    action :install
  end
}

make_tmp_dir TMP_ROOT do
  root_flag true
end

include_recipe "../cookbooks/bundler/default.rb"
include_recipe "../cookbooks/vim/default.rb"
cleanup_dir TMP_ROOT
