#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: deployment_message
#

include_recipe "trailmix::mail"
include_recipe "trailmix::messages"

# Send a server deployment details message to the deployer.

raise "PLEASE PROVIDE node.deployer_email_address" unless node["deployer_email_address"]

bash "send deployment message" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    sendmail #{node["deployer_email_address"]} < #{MAIL_FILES_DIRECTORY}/deployment.txt
  EOH
end
