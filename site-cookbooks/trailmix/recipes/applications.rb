#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: application
#

APPLICATION_DEPLOY_KEY_FILES = [
  {:name => "id_rsa", :permissions => "0600"},
  {:name => "id_rsa.pub", :permissions => "0644"},
  {:name => "config", :permissions => "0644"}
]

RBENV_BUNDLE_COMMAND_PREFIX = "bundle"

# Check for configured application.

raise "PLEASE PROVIDE -- node.ruby_version" unless node.ruby_version
raise "PLEASE PROVIDE -- node.application" unless node.application
raise "PLEASE PROVIDE -- node.application.source_url" unless node.application.source_url
raise "PLEASE PROVIDE -- node.application.name" unless node.application.name

RUBY_VERSION = node["ruby_version"]

APP_SOURCE_URL = node.application["source_url"]
APP_NAME = node.application["name"]
APP_RAKE_TASKS = node.application["tasks"]

APP_DIR = "/home/ec2-user/#{APP_NAME}"
APP_DEPLOY_KEYS_DIR = "/home/ec2-user/.ssh"
CHEF_DEPLOY_KEYS_DIR = "deploy_keys" # see: *site-cookbooks/trailmix/files/default*

APP_DIR_CURRENT= "#{APP_DIR}/current/"
APP_DEPLOY_KEY_NAME = "#{APP_DEPLOY_KEYS_DIR}/id_rsa"
CHEF_DEPLOY_KEY_NAME = "#{CHEF_DEPLOY_KEYS_DIR}/id_rsa"

#
# SOURCE CODE
#

# Install git.

package "git"

# Create application-specific directory to store deploy keys.

bash "create ssh sub-directory for #{APP_NAME} deploy keys" do
  user "ec2-user"
  code <<-EOH
    mkdir -p #{APP_DEPLOY_KEYS_DIR}
  EOH
end

# Upload application-specific deploy key files onto the server.

APPLICATION_DEPLOY_KEY_FILES.each do |file|
  cookbook_file "#{APP_DEPLOY_KEYS_DIR}/#{file[:name]}" do
    source "#{CHEF_DEPLOY_KEYS_DIR}/#{file[:name]}"
    owner "ec2-user"
    group "ec2-user"
    mode file[:permissions]
    backup false
  end
end

# Deploy code from hosted git source.

application APP_NAME do
  owner "ec2-user"
  group "ec2-user"
  path APP_DIR
  repository APP_SOURCE_URL
  revision "master"
  #deploy_key File.read(APP_DEPLOY_KEY_NAME) # File.read throws error upon initial deploy...
end

#
# RUBY AND GEMS
#

#### Install rbenv.
###
###node.default.rbenv["group_users"] = ["ec2-user"] # this works, but doesn't allow ec2-user to run rbenv commands...
###
###include_recipe "rbenv::default"
###
###include_recipe "rbenv::ruby_build"
###
###RBENV_DIR = node["rbenv"]["root_path"] # supplied by rbenv/attributes/default.rb, used by recipe 'rbenv::default'
###
#### Install ruby and set global ruby version for use by all shells. Initial installation is known to cause chef run to hang.
###
###rbenv_ruby RUBY_VERSION do
###  global true
###end
###
###bash "assign ownership of rbenv to ec2 user" do
###  user "root"
###  code <<-EOH
###    chown -R ec2-user #{RBENV_DIR}
###  EOH
###end
###
#### Install rubygems.
###
###rbenv_gem "bundler" do
###  ruby_version RUBY_VERSION
###end
###
###rbenv_gem "rails" do
###  ruby_version RUBY_VERSION
###  version "4.0.2"
###end
###
###rbenv_gem "rake" do
###  ruby_version RUBY_VERSION
###  # version "10.4.2"
###end
###
###rbenv_execute "bundle install rubygems for #{APP_NAME} app" do
###  user "ec2-user"
###  cwd APP_DIR
###  command "bundle install"
###  ruby_version RUBY_VERSION
###end

#
# DATABASE
#

# Create application database user (with admin privileges).

#mysql_database_user app["database"]["user_name"] do
#  connection ROOT_MYSQL_CONNECTION
#  password app["database"]["user_password"]
#  privileges ["all"]
#  # database_name app["database"]["name"]
#  action [:create, :grant]
#end

# Prepare application database.

#bash "manage application database" do
#  user "ec2-user"
#  cwd app_dir
#  code <<-BASH
#    #{RBENV_BUNDLE_COMMAND_PREFIX} exec rake db:create RAILS_ENV=production &&
#    #{RBENV_BUNDLE_COMMAND_PREFIX} exec rake db:migrate RAILS_ENV=production &&
#    #{RBENV_BUNDLE_COMMAND_PREFIX} exec rake db:seed RAILS_ENV=production
#  BASH
#end

#
# ASSETS
#

#bash "manage application assets" do
#  user "ec2-user"
#  cwd app_dir
#  code <<-BASH
#    #{RBENV_BUNDLE_COMMAND_PREFIX} exec rake assets:precompile
#  BASH
#end

#
# TASKS
#

#### Schedule rake tasks.
###
###bash "clear the crontab" do
###  user "ec2-user"
###  code <<-EOH
###    crontab -r
###  EOH
###  only_if { File.exist?("/var/spool/cron/ec2-user") }
###end
###
###if APP_RAKE_TASKS do
###  APP_RAKE_TASKS.each do |task_name, task|
###    notification_email_address = task["email_address"] || node["deployer_email_address"]
###    raise "PLEASE PROVIDE node.application.tasks.#{task_name}.cron_hour" unless task["cron_hour"]
###    raise "PLEASE PROVIDE node.application.tasks.#{task_name}.cron_minute" unless task["cron_minute"]
###    raise "PLEASE PROVIDE node.application.tasks.#{task_name}.email_address OR node.deployer_email_address" unless notification_email_address
###
###    cron "schedule execution of #{APP_NAME} rake task #{task_name}" do
###      hour task["cron_hour"]
###      minute task["cron_minute"]
###      user "ec2-user"
###      mailto notification_email_address
###      command <<-BASH
###        /bin/bash -l -c 'cd #{APP_DIR} && #{RBENV_BUNDLE_COMMAND_PREFIX} exec rake #{task_name} RAILS_ENV=production'
###      BASH
###      action :create
###    end
###  end
###end

#
# DEPLOY HOOKS
#

# Send deployment message

include_recipe "trailmix::deployment_message"
