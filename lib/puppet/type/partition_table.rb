# encoding: UTF-8
require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'utils/parted'
require 'utils/parted_command'


# @nodoc
module Puppet
  Type::newtype(:partition_table) do
    include EasyType
    include Utils::PartedCommand

    desc <<-EOT

    Manage the partition tables on a disk. A partition table must be available on a disk
    before you can define partitions on it.

    EOT

    set_command(:parted)

    on_create do | command_builder |
      make_partition_table
    end

    on_modify do | command_builder|
      make_partition_table
    end

    def make_partition_table
      "-s #{self[:name]} mklabel #{self[:ensure]}"
    end

    #
    # property  :new_property  # For every property and parameter create a parameter file
    #
    parameter :name
    parameter :ensure
    parameter :device_timeout

    #
  end
end
