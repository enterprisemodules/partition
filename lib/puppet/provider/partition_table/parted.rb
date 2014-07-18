# encoding: UTF-8
require 'easy_type'

Puppet::Type.type(:partition_table).provide(:parted) do
  include EasyType::Provider
  #
  # No need to add or remove anything here
  #
  desc 'This is the generic provider for a easy_type type'

  mk_resource_methods
end
