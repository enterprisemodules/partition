# encoding: UTF-8

newproperty(:end) do

  include EasyType

  desc 'The partition will start start from the beginning of the disk, and end end from the beginning of the disk.'

  to_translate_to_resource do | raw_resource|
    raw_resource.column_data('end')
  end

  munge do | value |
    if value.nil?
      value = last_free_sector
      Puppet.info "No end was defined. Using sector #{value} as end"
    end
    value
  end

  private

  def last_free_sector
    Puppet::Util::Execution.execute("parted #{resource[:device]} unit s print free |grep 'Free Space' | awk '{print $2}' ").chop
  end

end