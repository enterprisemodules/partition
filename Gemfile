source "http://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.7.0'
  gem "puppet-lint"
  gem "rspec-puppet"
  gem "puppet-syntax"
  gem "puppetlabs_spec_helper"
  gem 'librarian-puppet'
end

group :development do
  gem 'byebug'
  gem 'pry'
  gem "travis"
  gem "travis-lint"
  gem 'beaker'
  gem "beaker-rspec"
  gem "vagrant-wrapper"
  gem "puppet-blacksmith"
end
