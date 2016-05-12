%w(vim vim-gnome).each do |p|
  package p do
    action :install
  end
end

# activate vim-migemo
include_recipe "../cmigemo/default.rb"
