# encoding: UTF-8
require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'utils/parted'

# @nodoc
module Puppet
  newtype(:partition_table) do
    include EasyType

    desc <<-EOT

    Manage the partition tables on a disk. A partition table must be available on a disk
    before you can define partitions on it.

      EOT

    set_command(:parted)

    to_get_raw_resources do
      parted = Utils::Parted.new
      parted.tables
    end

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
    # -- end of attributes -- Leave this comment if you want to use the scaffolder

    #
  end
end
