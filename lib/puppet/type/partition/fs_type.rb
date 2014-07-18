# encoding: UTF-8


newproperty(:fs_type) do

  include EasyType
  newvalues(
    :ext2,
    :ext3,
    :fat32,
    :fat16,
    :HFS,
    :'linux-swap',
    :NTFS,
    :reiserfs,
    :ufs
  )

  desc <<-EOT

    You may specify a file system type, to set the appropriate partition code in the 
    partition table for the new partition. fs-type is required for data partitions 
    (i.e., non-extended partitions).'

  EOT
  #
  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('fs_type')
  end

  on_apply do
    "#{resource[:device]} mkfs #{resource[:minor]} #{resource[:fs_type]}"
  end

end