newparam(:device_timeout) do
  include EasyType::Mungers::Integer

  desc "The maximum time to wait until the device come's available."

  defaultto 20

end
