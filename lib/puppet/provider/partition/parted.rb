# encoding: UTF-8
require 'easy_type'

Puppet::Type.type(:partition).provide(:parted) do
  include EasyType::Provider
  #
  # No need to add or remove anything here
  #
  desc 'This is parted provider for the partition type'

  mk_resource_methods

  def self.prefetch(resources)
    parted = Utils::Parted.new
    resources.dup.each do |name, value|
      device = value['device']
      parted.wait_for_device(device, value[:device_timeout])
      device = File.realpath(device, '/dev') if File.symlink?(device)
      if device != value['device']
        value['device'] = device
        resources.delete(name)
        resources["#{device}:#{value[:minor]}"] = value
      end
      full_name = "#{device}:#{value[:minor]}"
      parted.show(device, value['unit'].to_s)
      parted.partitions.each do | partition |
        provider = map_raw_to_resource(partition)
        resources[full_name].provider = provider if provider.name == full_name
      end
    end
  end

  def self.instances
    parted = Utils::Parted.new
    parted.list
    parted.partitions.map do |raw_resource|
      map_raw_to_resource(raw_resource)
    end
  end

end
