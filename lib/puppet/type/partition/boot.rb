# encoding: UTF-8

newproperty(:boot) do

  include EasyType
  desc  <<-EOT

  (Mac, MSDOS, PC98) - should be enabled if you want to boot off the partition. 
  The semantics vary between disk labels. For MSDOS disk labels, only one partition can 
  be bootable. If you are installing LILO on a partition (see section 4.1 LILO: a 
  bootloader for the Linux kernel), then that partition must be bootable. For PC98 disk 
  labels, all ext2 partitions must be bootable (this is enforced by Parted).

  EOT

  to_translate_to_resource do | raw_resource|
    flags = raw_resource.column_data('flags')
    (flags && flags.scan(/boot/).size == 1).to_s
  end

  on_apply do | command_builder |
    resource[:boot] ? "set #{resource[:minor]} boot on" : "set #{resource[:minor]} boot off"
  end


end