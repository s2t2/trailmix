#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: ruby
#

# Install rbenv.

node.default.rbenv["group_users"] = ["ec2-user"]

include_recipe "rbenv::default"

include_recipe "rbenv::ruby_build"

# Install ruby. Note: initial ruby installation may cause chef run to hang.

rbenv_ruby node["ruby_version"] do
  global true
end

rbenv_command("rehash")

bash "assign ownership of rbenv to ec2 user" do
  user "root"
  code <<-EOH
    chown -R ec2-user #{node["rbenv"]["root_path"]}
  EOH
end
