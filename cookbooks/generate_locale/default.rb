execute "generate ja-JP.UTF-8" do
  command "locale-gen ja_JP.UTF-8"
  not_if "test ja_JP.UTF-8 = `locale -a | grep ja_JP.UTF-8`"
end
