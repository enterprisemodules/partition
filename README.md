[![Build Status](https://travis-ci.org/hajee/partition.png?branch=master)](https://travis-ci.org/hajee/partition)

####Table of Contents

[![Powered By EasyType](https://raw.github.com/hajee/easy_type/master/powered_by_easy_type.png)](https://github.com/hajee/easy_type)


1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with partition](#setup)
    * [What partition affects](#what-partition-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
    * [OS support](#os-support)
    * [Tests - Testing your configuration](#testing)

##Overview

This module contains the custom types to manage partitions and partition tables. It implemements most of the linux `parted` functionality.

##Module Description

This module contains custom types that can help you manage DBA objects in an Oracle database. It runs **after** the database is installed. IT DOESN'T INSTALL the Oracle database software. With this module, you can setup a database to receive an application. You can:


##Setup

###What partition affects

The types in this module will change disks. Most of the functionality is destructive. Just like adding or changing partitions normaly is. So **be careful**. Be sure to have a goof backup of the devices you want these types to manage.


###Setup Requirements

This module is based on [easy_type](https://github.com/hajee/easy_type). So you need to install [easy_type](https://github.com/hajee/easy_type), and this module.

```sh
puppet module install hajee/easy_type
puppet module install hajee/partition
```

##Usage

The module contains the following types:

`partition` and `partition_table`

Here are a couple of examples on how to use them.

###partition_table


```puppet
partition_table {'/dev/sda':
  ensure  => 'msdos',
}
```

This puppet statement create's a msdos partition table on device /dev/sda. Any partitions available on the disk before this statement, are wipped. You can use the following partition types:

* bsd
* loop (raw disk access)
* gpt
* mac
* msdos
* pc98
* sun

###partition


```puppet
partition { '/dev/hda:1':
  ensure    => 'present',
  boot      => 'true',
  end       => '107MB',
  fs_type   => 'ext3',
  lvm       => 'false',
  part_type => 'primary',
  start     => '32.3kB',
}
```


When you add a `gpt` partition, you have to set the partition name. If you specify a `partition_type`, it is simply ignored.

```puppet
partition { '/dev/hda:1':
  ensure    => 'present',
  boot      => 'true',
  end       => '107MB',
  part_name => 'my_part',
  start     => '32.3kB',
}
```

This pupet code manages the first partition on /dev/hda. To check what all properties mean, checkout the documentation.

##Limitations

This module is developed on a CentOS 5 system. It uses `parted` to do the actual work. Because `parted` uses it's own units for `start` and `end` parameters, you have to be careful to match the unit's it returns when using a `parted -l` versus what's in your manifest. I intend to improve on tis, but it's not there yet.


##Development

This is an open projects, and contributions are welcome. 

###OS support

Currently we have tested:

* CentOS 5.8

It would be great if we could get it working and tested on:

* Debian
* Ubuntu
* ....


###Testing

Sorry, not tests yet.
