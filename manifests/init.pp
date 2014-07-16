# == Class: partition
#
# Full description of class partition here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class partition (
) inherits partition::params {

  # validate parameters here

  class { 'partition::install': } ->
  class { 'partition::config': } ~>
  class { 'partition::service': } ->
  Class['partition']
}
