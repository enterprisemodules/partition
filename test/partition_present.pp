partition { '/dev/sdb:1':
  ensure    => 'present',
  part_type => 'primary',
}