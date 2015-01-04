#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: applications
#

if node.applications.any?

  # Install git package.

  package "git"

  node.applications.each do |app_name, app|
    deploy_keys_directory_path = "/home/ec2-user/.ssh/applications/#{app_name}/deploy_keys"

    # Create dedicated directory for storing application-specific deploy keys.

    bash "create ssh sub-directory for #{app_name} deploy keys" do
      user "ec2-user"
      code <<-EOH
        mkdir -p #{deploy_keys_directory_path}
      EOH
    end

    # Place deploy keys onto the node.

    APPLICATION_DEPLOY_KEY_FILES.each do |file|
      cookbook_file "#{deploy_keys_directory_path}/#{file[:name]}" do
        source "applications/#{app_name}/deploy_keys/#{file[:name]}"
        owner "ec2-user"
        group "ec2-user"
        mode file[:permissions]
        backup false
      end
    end

    # Deploy application source code from github.

    application app_name do
      owner "ec2-user"
      group "ec2-user"
      path app["code"]["destination_path"]
      repository app["code"]["source_url"]
      deploy_key File.read("#{deploy_keys_directory_path}/id_rsa")
    end

    #app_dir = "#{app["code"]["destination_path"]}/current/"

    #bash "bundle install rubygems" do
    #  user "ec2-user"
    #  cwd app_dir
    #  code <<-BASH
    #    #{rbenv_bundle} install
    #  BASH
    #end

    #mysql_database_user app["database"]["user_name"] do
    #  connection root_mysql_connection
    #  password app["database"]["user_password"]
    #  privileges ["all"]
    #  # database_name app["database"]["name"]
    #  action [:create, :grant]
    #end

    #bash "manage application database" do
    #  user "ec2-user"
    #  cwd app_dir
    #  code <<-BASH
    #    #{rbenv_bundle} exec rake db:create RAILS_ENV=production &&
    #    #{rbenv_bundle} exec rake db:migrate RAILS_ENV=production &&
    #    #{rbenv_bundle} exec rake db:seed RAILS_ENV=production
    #  BASH
    #end

    #bash "manage application assets" do
    #  user "ec2-user"
    #  cwd app_dir
    #  code <<-BASH
    #    #{rbenv_bundle} exec rake assets:precompile
    #  BASH
    #end
  end

end