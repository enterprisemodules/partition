# encoding: UTF-8

newproperty(:raid) do

  include EasyType
  desc  <<-EOT

  (MSDOS) - this flag can be enabled to tell linux the partition is a software RAID 
  partition See section 7. LVM and RAID.

  EOT

  to_translate_to_resource do | raw_resource|
    flags = raw_resource.column_data('flags')
    flags && flags.scan(/raid/).size == 1
  end

  on_apply do
    #TODO: make it work
  end


end