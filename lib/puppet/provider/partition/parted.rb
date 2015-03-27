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
    resources.each do |name, value|
      parted.show(value['device'] )
      parted.partitions.each do | partition |
        provider = map_raw_to_resource(partition)
        resources[name].provider = provider if provider.name == name
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
