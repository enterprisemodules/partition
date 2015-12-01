# encoding: UTF-8


newproperty(:fs_type) do

  include EasyType

  desc <<-EOT

    You may specify a file system type, to set the appropriate partition code in the 
    partition table for the new partition. fs-type is required for data partitions 
    (i.e., non-extended partitions).'

  EOT
  #
  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('file system')
  end

  on_apply do | command_builder |
    device_name = resource[:name].gsub(':','')
    command_builder.after("#{device_name} -t #{resource[:fs_type]}", 'mkfs')
  end

end
