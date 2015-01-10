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
  version "10.4.2"
  #options {"--force"} # passing force option doesn't fix the problem ...
  not_if "which rake" # a temporary fix for a known ruby bug? https://github.com/poise/application_ruby/pull/45#issuecomment-41134256
end
