#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: mail
#

# Install sendmail package.

package "sendmail"
package "sendmail-cf"

# Upload sendmail configuration files.

template "/etc/mail/local-host-names" do
  source "mail/local-host-names.erb"
  owner "root"
  group "root"
end

template "/etc/mail/sendmail.mc" do
  source "mail/sendmail.mc.erb"
  owner "root"
  group "root"
end

# Configure sendmail according to configuration files.

bash "regenerate sendmail.cf from sendmail.mc" do
  code "/etc/mail/make"
  user "root"
end

# Restart sendmail to apply changes in configuration.

bash "restart sendmail service" do
  code "/etc/init.d/sendmail reload"
  user "root"
end
