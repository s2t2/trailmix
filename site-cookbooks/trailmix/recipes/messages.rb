#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: messages
#

# Create a directory for storing mail files.

directory MAIL_FILES_DIRECTORY do
  owner "ec2-user"
  group "ec2-user"
  mode "0755"
  action :create
end

# Upload mail file to be sent during deployment.

upload_mail_file("deployment.txt") if node.recipes.include?("trailmix::deploy")
