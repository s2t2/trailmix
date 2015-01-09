#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: ebs_filesystem
#

# Create directory for the ebs filesystem.

directory EBS_FILESYSTEM_DIRECTORY do
  owner "root"
  group "root"
  mode 00777
  action :create
end

# Update fstab to include ebs filesystem.

template "update fstab" do
  path "/etc/fstab"
  source "fstab.erb"
  owner "root"
  group "root"
end

# Mount filesystem.

bash "mount filesystem unless already mounted" do 
  code <<-EOH
    if mountpoint {EBS_FILESYSTEM_DIRECTORY}; then echo "FILESYSTEM IS ALREADY MOUNTED."; else mkfs -t ext4 /dev/xvdb && mount /dev/xvdb {EBS_FILESYSTEM_DIRECTORY}/; fi
  EOH
  user "root"
  group "root"
  action :run
end
