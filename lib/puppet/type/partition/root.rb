# encoding: UTF-8

newproperty(:root) do

  include EasyType
  desc  <<-EOT

  (Mac) - this flag should be enabled if the partition is the root device to be used by
  Linux.

  EOT

  to_translate_to_resource do | raw_resource|
    flags = raw_resource.column_data('flags')
    flags && flags.scan(/root/).size == 1
  end

  on_apply do
    "set #{resource[:minor]} root"
  end


end