# encoding: UTF-8

newproperty(:part_name) do

  include EasyType

  desc <<-EOT

    Contains the partition name for an GUID partition.

  EOT

  to_translate_to_resource do | raw_resource|
    #
    # type is optionaly available. So check if it is before extracting the column data
    #
    raw_resource.column_data('name') if type_available?(raw_resource)
  end

  def self.type_available?(raw_resource)
    raw_resource.keys.include?('name')
  end

end