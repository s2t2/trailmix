#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: ruby
#

# Install rbenv.

node.default.rbenv["group_users"] = ["ec2-user"]

include_recipe "rbenv::default"

include_recipe "rbenv::ruby_build"

rbenv_command("rehash")

# Install ruby. Note: initial ruby installation may cause chef run to hang.

rbenv_ruby node["ruby_version"] do
  global true
end
