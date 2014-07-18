# encoding: UTF-8

newproperty(:ensure) do

  include EasyType
  newvalues(
    :bsd,
    :loop,
    :gpt,
    :mac,
    :msdos,
    :pc98,
    :sun
  )

  desc <<-EOT

    Type label-type. The new disk label will have no partitions. This command (normally)
    won't technically destroy your data, but it will make it will make it basically unusable, 
    and you will need to use the rescue command (see section 9. Related Software and Info) to
    recover any partitions. Gpart only works for msdos disk labels (AFAIK), but is much better
    than parted at recovering partitions. Parted works on all partition tables. (1)

      label-type must be one of these supported disk labels:

      bsd
      loop (raw disk access)
      gpt
      mac
      msdos
      pc98
      sun

  EOT
  #
  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('type')
  end

end