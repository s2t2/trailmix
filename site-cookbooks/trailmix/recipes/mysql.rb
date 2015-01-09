#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: mysql
#

# Mount and install a filesystem on the ebs drive.

include_recipe "trailmix::ebs_filesystem"

# Create data directory.

#directory DATA_DIRECTORY do
#  owner "root"
#  group "root"
#  mode 00777
#  action :create
#end

# Create temporary data directory.

#directory TEMPORARY_DATA_DIRECTORY do
#  owner "root"
#  group "root"
#  mode 00777
#  action :create
#end

# Set mysql attributes.

node.default["mysql"]["data_dir"] = DATA_DIRECTORY
node.default["mysql"]["server_root_password"] = "OVERWRITE_ME"
node.default["mysql"]["server_repl_password"] = "OVERWRITE_ME" # is this necessary?
node.default["mysql"]["server_debian_password"] = "OVERWRITE_ME" # is this necessary?

node.default["mysql"]["bind_address"] = "127.0.0.1"

node.default["mysql"]["remove_anonymous_users"] = true # not sure this actually works...
node.default["mysql"]["allow_remote_root"] = false # not sure this actually works...
node.default["mysql"]["remove_test_database"] = true

node.default["mysql"]["server"]["tmpdir"] = [TEMPORARY_DATA_DIRECTORY]
node.default["mysql"]["server"]["slow_query_log_file"] = SLOW_QUERY_LOG_FILE
node.default["mysql"]["server"]["socket"] = "/tmp/mysql.sock"
node.default["mysql"]["server"]["packages"] = []

node.default["mysql"]["tunable"]["character-set-server"] = "utf8" # pretty sure tunable attributes are deprecated ...
node.default["mysql"]["tunable"]["collation-server"] = "utf8_general_ci" # pretty sure tunable attributes are deprecated ...

# Install mysql server.

package "mysql-server"
include_recipe "mysql::server"
include_recipe "mysql::ruby"

# Remove non-localhost mysql users.

bash "remove non-localhost-mysql-users" do
  code <<-EOH
    mysql -u root --password=#{ROOT_MYSQL_CONNECTION[:password]} -e "DELETE FROM mysql.user WHERE host <> 'localhost';"
  EOH
  action :run
end

# Overwrite mysql configuration file.

template "mysql service configuration" do
  path "/home/ec2-user/.my.cnf"
  source "mysql.conf.erb"
  owner "ec2-user"
  mode 0600
end

# Restart mysql server?

#todo
