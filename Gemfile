source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_GEM_VERSION') ? "#{ENV['PUPPET_GEM_VERSION']}" :  '4.10.8'

gem 'puppet', puppetversion, :require => false, :groups => [:test]
if Gem::Version.new(puppetversion) > Gem::Version.new('5.0.0')
  #
  # PDK 1.8 doesn't include dot files. We MUST have those. Until 1.9 is released
  # we fetch it from the master of the github
  #
  gem 'pdk', :git => 'https://github.com/puppetlabs/pdk.git'
end

group :unit_test do
  gem 'hiera-puppet-helper'
  gem 'rspec-puppet'
  gem 'rspec-puppet-utils'
  gem 'mocha', '1.3.0'
end
group :acceptance_test do
  gem 'beaker', :require => false, :git => 'https://github.com/enterprisemodules/beaker.git'
  gem 'beaker-docker', :ref => '52a5fc118e699e01679e02d25e346e92142fead9', :git => 'https://github.com/enterprisemodules/beaker-docker.git'
  gem 'beaker-hiera'
  gem 'beaker-module_install_helper'
  gem 'beaker-pe'
  gem 'beaker-puppet_install_helper'
  gem 'beaker-rspec'
  gem 'rspec-retry'
end

group :release do
  gem 'puppet-blacksmith'
end

group :quality do
  gem 'brakeman'
  gem 'bundler-audit',  git: 'https://github.com/rubysec/bundler-audit.git'  
  gem 'fasterer'
  gem 'metadata-json-lint'
  gem 'overcommit', :git => 'https://github.com/brigade/overcommit.git'
  gem 'puppet-lint'
  gem 'reek'
  gem 'rubocop', :require => false
end

group :unit_test, :acceptance_test do
  gem 'easy_type_helpers', :git => 'https://github.com/enterprisemodules/easy_type_helpers.git'
  gem 'puppetlabs_spec_helper'
end
