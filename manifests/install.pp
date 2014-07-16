# == Class partition::install
#
class partition::install {
  include partition::params

  package { $partition::params::package_name:
    ensure => present,
  }
}
