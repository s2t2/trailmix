#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: crontab
#

bash "clear the crontab" do
  user "ec2-user"
  code <<-EOH
    crontab -r
  EOH
  only_if { File.exist?("/var/spool/cron/ec2-user") }
end

#app["scheduled_rake_tasks"].each do |task_name, task|
#  cron "schedule execution of #{app_name} rake task #{task_name}" do
#    hour task["cron_hour"]
#    minute task["cron_minute"]
#    user "ec2-user"
#    mailto task["cron_recipient_email_address"]
#    command <<-BASH
#      /bin/bash -l -c 'cd #{app_dir} && #{rbenv_bundle} exec rake #{task_name} RAILS_ENV=production'
#    BASH
#    action :create
#  end
#end
