module TrailmixHelper
  MAIL_FILES_DIRECTORY = "/home/ec2-user/mail_files"

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

Chef::Recipe.send(:include, TrailmixHelper)
