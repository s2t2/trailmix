#
# Author:: MJ Rossetti (@s2t2)
# Cookbook Name:: trailmix
# Recipe:: rubygems
#

# Install rubygems.

rbenv_gem "bundler" do
  ruby_version node["ruby_version"]
end

rbenv_gem "rails" do
  ruby_version node["ruby_version"]
  version "4.0.2"
end

rbenv_gem "rake" do
  ruby_version node["ruby_version"]
  # version "10.4.2"
end
