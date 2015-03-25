# encoding: UTF-8
require 'easy_type'
require 'utils/multipathd'

Puppet::Type.type(:partition).provide(:single) do
  include EasyType::Provider
  #
  # No need to add or remove anything here
  #
  desc 'This is the non prefetching provider for the partition type'

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
    fail 'the single instance provider doesn\'t support the resource command'
  end

end
