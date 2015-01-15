#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: ruby
#

# Install rbenv.

node.default.rbenv["group_users"] = ["ec2-user"] # this works, but doesn't allow ec2-user to run rbenv commands...

include_recipe "rbenv::default"

include_recipe "rbenv::ruby_build"

# Install ruby and set global ruby version for use by all shells. Initial installation is known to cause chef run to hang.

rbenv_ruby node["ruby_version"] do
  global true
end

bash "assign ownership of rbenv to ec2 user" do
  user "root"
  code <<-EOH
    chown -R ec2-user #{node["rbenv"]["root_path"]}
  EOH
end
