module TrailmixHelper
  MAIL_FILES_DIRECTORY = "/home/ec2-user/mail_files"

  APPLICATION_DEPLOY_KEY_FILES = [
    {:name => "id_rsa", :permissions => "0600"},
    {:name => "id_rsa.pub", :permissions => "0644"},
    {:name => "config", :permissions => "0644"}
  ]

  EBS_FILESYSTEM_DIRECTORY = "/ebs_filesystem"

  #ROOT_MYSQL_CONNECTION = {
  #  :host => "localhost",
  #  :username => "root",
  #  :password => node["mysql"]["server_root_password"]
  #}

  def upload_mail_file(mail_file)
    template "#{MAIL_FILES_DIRECTORY}/#{mail_file}" do
      source "mail/messages/#{mail_file}.erb"
      owner "ec2-user"
      group "ec2-user"
    end
  end
end

# Allow helper module to invoke chef recipe methods; allow all recipes to access module content.
Chef::Recipe.send(:include, TrailmixHelper)

# How to allow helper to access node attributes?
# ...
