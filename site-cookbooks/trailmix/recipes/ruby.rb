#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: ruby
#

# Install rbenv.

node.default.rbenv["group_users"] = ["ec2-user"]

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

# Install ruby and set the global version to be used in all shells.

node.default.ruby_version = "2.2.0"

rbenv_ruby node["ruby_version"] do
  global true
end
