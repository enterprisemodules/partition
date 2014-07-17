# encoding: UTF-8

newproperty(:lba) do

  include EasyType
  desc  <<-EOT

  MSDOS) - this flag can be enabled, to tell MS DOS, MS Windows 9x and MS Windows ME based
  operating systems to use Linear (LBA) mode.

  EOT

  to_translate_to_resource do | raw_resource|
    flags = raw_resource.column_data('flags')
    flags && flags.scan(/lba/).size == 1
  end

  on_apply do
    #TODO: make it work
  end


end