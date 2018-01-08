# encoding: UTF-8
require 'easy_type'

Puppet::Type.type(:partition_table).provide(:parted) do
  include EasyType::Provider
  #
  # No need to add or remove anything here
  #
  desc 'This is the parted provider for the partition type'

  mk_resource_methods

  def self.prefetch(resources)
    parted = Utils::Parted.new
    resources.dup.each do |name, value|
      device = value['name']
      device = File.realpath(device, '/dev') if File.symlink?(device)
      if device != value['name']
        resources.delete(name)
        resources[device] = value
      end
      parted.show(device )
      parted.tables.each do | table |
        provider = map_raw_to_resource(table)
        resources[device].provider = provider if provider.name == device
      end
    end
  end

  def self.instances
    parted = Utils::Parted.new
    parted.list
    parted.tables.map do |raw_resource|
      map_raw_to_resource(raw_resource)
    end
  end

end
