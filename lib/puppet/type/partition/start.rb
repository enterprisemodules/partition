# encoding: UTF-8

newproperty(:start) do

  include EasyType

  desc 'The partition will start start from the beginning of the disk, and end end from the beginning of the disk.'

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('start')
  end
end