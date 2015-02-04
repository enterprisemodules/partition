# encoding: UTF-8

newproperty(:start) do

  include EasyType

  desc 'The partition will start start from the beginning of the disk, and end end from the beginning of the disk.'

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('start')
  end

  munge do | value |
    if value.nil?
      value = first_free_sector
      Puppet.info "No start defined. Using sector #{value} as start"
    end
    value
  end

  private

  def first_free_sector
    Puppet::Util::Execution.execute("parted #{resource[:device]} unit s print free |grep 'Free Space' | awk '{print $1}' ").chop
  end

end