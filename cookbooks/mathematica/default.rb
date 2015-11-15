# this recipe is for raspbian only

# mathematica on raspy require video group to auth
add_user_to_group node['username'] do
  group "video"
end

package "wolfram-engine" do
  action :install
end
