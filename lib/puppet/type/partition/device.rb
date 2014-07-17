newparam(:device) do
  include EasyType
  include EasyType::Validators::Name
  include EasyType::Mungers::String

  isnamevar
  desc "Device name "

  #
  # Is filled by map_title_to_attributes
  #

end
