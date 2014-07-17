# encoding: UTF-8

newparam(:minor) do

  include EasyType
  desc  <<-EOT


  EOT

  isnamevar

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('minor')
  end

  on_apply do
    #TODO: make it work
  end


end