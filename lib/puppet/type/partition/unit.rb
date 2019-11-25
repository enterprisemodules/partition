# encoding: UTF-8

newparam(:unit) do
  desc  <<-EOT

  This flag tells the module to manage the resource using the unit specified

  EOT

  newvalues(:s, :b, :kb, :mb, :mib, :gb, :gib, :tb, :tib, :%, :cyl, :chs, :compact)
  defaultto 'mb'
end