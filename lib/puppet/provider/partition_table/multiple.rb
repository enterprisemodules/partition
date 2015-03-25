# encoding: UTF-8
require 'easy_type'
require 'utils/multipathd'

Puppet::Type.type(:partition_table).provide(:multiple) do
  confine :false => Utils::Multipathd.running?
  defaultfor :osfamily => :redhat

  include EasyType::Provider
  #
  # No need to add or remove anything here
  #
  desc 'This is the generic provider for a easy_type type'

  mk_resource_methods

  self.instance_eval { undef :instances }

  def self.instances
    parted = Utils::Parted.new
    parted.list
    parted.tables.map do |raw_resource|
      map_raw_to_resource(raw_resource)
    end
  end

end
