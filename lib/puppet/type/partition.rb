# encoding: UTF-8
require 'pathname'
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent)
$:.unshift(Pathname.new(__FILE__).dirname.parent.parent.parent.parent + 'easy_type' + 'lib')
require 'utils/parted'
require 'utils/parted_command'

# @nodoc
module Puppet
  Type::newtype(:partition) do
    include EasyType
    include EasyType::Helpers
    include Utils::PartedCommand

    desc "create and modify partitions on a disk"

    ensurable

    set_command(:parted)

    on_create do | command_builder |
      parameter = part_type ? part_type : part_name
      "-s #{device} mkpart #{parameter} #{actual_start} #{actual_end}"
    end

    on_modify do | command_builder|
      "-s #{device}"
    end

    on_destroy do |command_builder|
      "-s #{device} rm #{minor}"
    end

    #
    # Title is device/name
    #
    map_title_to_attributes(:name, :device, :minor) do
      /^((.*):(.*))$/
    end

    parameter :name
    parameter :device
    parameter :minor
		property  :start
		property  :end
		property  :fs_type
		property  :part_type
    property  :part_name
		property  :boot
		property  :lba
		property  :root
		property  :swap
		property  :hidden
		property  :raid
		property  :lvm
    # -- end of attributes -- Leave this comment if you want to use the scaffolder
    #
    private

    def actual_start
      if self[:start].nil?
        value = first_free_sector
        Puppet.info "No start was defined. Using sector #{value} as start"
        value
      else
        self[:start]
      end
    end

    def actual_end
      if self[:end].nil?
        value = last_free_sector
        Puppet.info "No end was defined. Using sector #{value} as end"
        value
      else
        self[:end]
      end
    end

    def last_free_sector
      Puppet::Util::Execution.execute("parted #{device} unit s print free |grep 'Free Space' | awk '{print $2}' ").chop
    end

    def first_free_sector
      Puppet::Util::Execution.execute("parted #{device} unit s print free |grep 'Free Space' | awk '{print $1}' ").chop
    end

  end
end
