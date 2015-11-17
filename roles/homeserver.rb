include_recipe "./infrastructure.rb"

include_recipe "../cookbooks/wlan/default.rb"
include_recipe "../cookbooks/smb/default.rb"
include_recipe "../cookbooks/minidlna/default.rb"
include_recipe "../cookbooks/docker/default.rb"
