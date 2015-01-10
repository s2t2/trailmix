#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: ruby_and_gems
#

# Specify node attributes for use by the "rbenv::system_install" recipe, which installs rbenv.

node.default["rbenv"]["root_path"] = "/home/ec2-user/rbenv"

# Install ruby.

RUBY_VERSION = "2.2.0"

rbenv_ruby RUBY_VERSION

# Switch to desired global ruby version.

rbenv_global RUBY_VERSION

# Install rubygems.

rbenv_gem "bundler" do
  rbenv_version RUBY_VERSION
end

rbenv_gem "rails" do
  rbenv_version RUBY_VERSION
  version "4.0.2"
end

rbenv_gem "rake" do
  rbenv_version RUBY_VERSION
  #version "10.1.1"
  #options {"--force"} # https://github.com/fnichol/chef-rbenv/issues/64
end
