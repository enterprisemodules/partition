# == Class partition::service
#
# This class is meant to be called from partition
# It ensure the service is running
#
class partition::service {
  include partition::params

  service { $partition::params::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
