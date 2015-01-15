#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: mysql
#

# Mount and install a filesystem on the ebs drive.

include_recipe "trailmix::ebs_filesystem"

# Create temporary data directory.

#TEMPORARY_DATA_DIRECTORY = "/#{EBS_FILESYSTEM_DIRECTORY}/tmp"
#
#directory TEMPORARY_DATA_DIRECTORY do
#  owner "root"
#  group "root"
#  mode 00777
#  action :create
#end

# Set mysql attributes.

# node.default["mysql"]["server_root_password"] = "OVERWRITE_ME"
# node.default["mysql"]["server_repl_password"] = "OVERWRITE_ME" # is this necessary?
# node.default["mysql"]["server_debian_password"] = "OVERWRITE_ME" # is this necessary?
# node.default["mysql"]["data_dir"] = "/#{EBS_FILESYSTEM_DIRECTORY}/data"
# node.default["mysql"]["bind_address"] = "127.0.0.1"
# node.default["mysql"]["remove_anonymous_users"] = true # not sure this actually works...
# node.default["mysql"]["allow_remote_root"] = false # not sure this actually works...
# node.default["mysql"]["remove_test_database"] = true
# 
# node.default["mysql"]["server"]["tmpdir"] = [TEMPORARY_DATA_DIRECTORY]
# node.default["mysql"]["server"]["slow_query_log_file"] = "/#{EBS_FILESYSTEM_DIRECTORY}/logs/mysql/slow.log"
# node.default["mysql"]["server"]["socket"] = "/tmp/mysql.sock"
# node.default["mysql"]["server"]["packages"] = []
# 
# node.default["mysql"]["tunable"]["character-set-server"] = "utf8" # pretty sure tunable attributes are deprecated ...
# node.default["mysql"]["tunable"]["collation-server"] = "utf8_general_ci" # pretty sure tunable attributes are deprecated ...

# Install mysql server.

# package "mysql-community-server"

mysql_service "default" do
  bind_address "127.0.0.1"
  data_dir "#{EBS_FILESYSTEM_DIRECTORY}/data"
  initial_root_password node["mysql"]["server_root_password"]
  port "3306"
  version "5.6"
  action [:create, :start]
end

# Overwrite mysql configuration file.

### template "mysql service configuration" do
###   path "/home/ec2-user/.my.cnf"
###   source "mysql.conf.erb"
###   owner "ec2-user"
###   mode 0600
### end

#mysql_config "default" do
#  source "mysql.conf.erb"
#  variables( :mysql_applications => node[:applications] )
#  notifies :restart, 'mysql_service[default]'
#  action :create
#end

# Remove non-localhost mysql users.

# bash "remove non-localhost-mysql-users" do
#   code <<-EOH
#     mysql -h 127.0.0.1 -u root -e "DELETE FROM mysql.user WHERE host <> 'localhost';"
#   EOH
#   action :run
# end

 #   mysql -u root --password=#{node["mysql"]["server_root_password"]} -e "DELETE FROM mysql.user WHERE host <> 'localhost';"

