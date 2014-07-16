# == Class partition::params
#
# This class is meant to be called from partition
# It sets variables according to platform
#
class partition::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'partition'
      $service_name = 'partition'
    }
    'RedHat', 'Amazon': {
      $package_name = 'partition'
      $service_name = 'partition'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
