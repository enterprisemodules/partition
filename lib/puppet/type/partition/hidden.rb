# encoding: UTF-8

newproperty(:hidden) do

  include EasyType
  desc  <<-EOT

  (MSDOS, PC98) - this flag can be enabled to hide partitions from Microsoft operating 
  systems.

  EOT

  to_translate_to_resource do | raw_resource|
    flags = raw_resource.column_data('flags')
    flags && flags.scan(/hidden/).size == 1
  end

  on_apply do
    #TODO: make it work
  end


end