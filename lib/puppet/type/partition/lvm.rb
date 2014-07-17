# encoding: UTF-8

newproperty(:lvm) do

  include EasyType
  desc  <<-EOT

  (MSDOS) - this flag can be enabled to tell linux the partition is a physical volume.

  EOT

  to_translate_to_resource do | raw_resource|
    flags = raw_resource.column_data('flags')
    flags && flags.scan(/lvm/).size == 1
  end

  on_apply do
    #TODO: make it work
  end


end