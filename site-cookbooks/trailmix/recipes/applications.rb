#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: applications
#

# Check for configured applications.

if node.applications.any?

  # Install git.

  package "git"

  # Install ruby and gems.

  include_recipe "trailmix::ruby_and_gems"

  # Install and configure mysql.

  #RBENV_BUNDLE = "#{node["rbenv"]["root_path"]}/shims/bundle"

  #include_recipe "trailmix::mysql"

  # Deploy each configured application.

  node.applications.each do |app_name, app|

    # Create application-specific directory to store deploy keys.

    deploy_keys_directory_path = "/home/ec2-user/.ssh/applications/#{app_name}/deploy_keys"

    bash "create ssh sub-directory for #{app_name} deploy keys" do
      user "ec2-user"
      code <<-EOH
        mkdir -p #{deploy_keys_directory_path}
      EOH
    end

    # Upload application-specific deploy key files onto the server.

    APPLICATION_DEPLOY_KEY_FILES.each do |file|
      cookbook_file "#{deploy_keys_directory_path}/#{file[:name]}" do
        source "applications/#{app_name}/deploy_keys/#{file[:name]}"
        owner "ec2-user"
        group "ec2-user"
        mode file[:permissions]
        backup false
      end
    end

    # Deploy application-specific code from git source.

    application app_name do
      owner "ec2-user"
      group "ec2-user"
      path app["code"]["destination_path"]
      repository app["code"]["source_url"]
      deploy_key File.read("#{deploy_keys_directory_path}/id_rsa")
    end

    app_dir = "#{app["code"]["destination_path"]}/current/"

    # Install application-specific rubygems from the Gemfile.

    #bash "bundle install #{app_name} rubygems" do
    #  user "ec2-user"
    #  cwd app_dir
    #  code <<-BASH
    #    #{RBENV_BUNDLE} install
    #  BASH
    #end

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

    #bash "manage application assets" do
    #  user "ec2-user"
    #  cwd app_dir
    #  code <<-BASH
    #    #{RBENV_BUNDLE_COMMAND_PREFIX} exec rake assets:precompile
    #  BASH
    #end
  end

end