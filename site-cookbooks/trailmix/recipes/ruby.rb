#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: ruby
#

node.default["rbenv"]["root_path"] = "/home/ec2-user/rbenv"

#   + git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
#   + echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
#   + echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
#   + sudo yum install gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel
#   + git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
#   + rbenv install 1.9.3-p484
#   + rbenv rehash
#   + rbenv global 1.9.3-p484
#   + rbenv shell 1.9.3-p484

#TODO: add `sudo yum install ruby-devel` to the pre-configured AMI as well