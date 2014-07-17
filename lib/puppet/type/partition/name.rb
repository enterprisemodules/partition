newparam(:name) do
  include EasyType
  include EasyType::Validators::Name
  include EasyType::Mungers::String

  desc "partition's name "

  isnamevar

  to_translate_to_resource do | raw_resource|
    device = raw_resource.column_data('device').strip
    minor = raw_resource.column_data('minor').strip
    "/dev/#{device}:#{minor}"
  end

end
