# encoding: UTF-8

newproperty(:part_type) do

  include EasyType
  newvalues(
    :primary,
    :extended,
    :logical
  )

  desc <<-EOT

    You may specify a file system type, to set the appropriate partition code in the 
    partition table for the new partition. fs-type is required for data partitions 
    (i.e., non-extended partitions).'

  EOT

  to_translate_to_resource do | raw_resource|
    #
    # type is optionaly available. So check if it is before extracting the column data
    #
    raw_resource.column_data('type') if type_available?(raw_resource)
  end

  def self.type_available?(raw_resource)
    raw_resource.keys.include?('type')
  end

end