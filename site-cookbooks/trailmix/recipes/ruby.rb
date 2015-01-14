#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: ruby
#

# Install rbenv.

node.default.rbenv["group_users"] = ["ec2-user"]

include_recipe "rbenv::default"

include_recipe "rbenv::ruby_build"

# Install ruby. This step may cause the chef run to hang during initial installation.

node.default.ruby_version = "2.1.2"

rbenv_command("rehash")

# Set global ruby version to be used in all shells.

rbenv_ruby node["ruby_version"] do
  global true
end
