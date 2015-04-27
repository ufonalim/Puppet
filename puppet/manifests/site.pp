node default {

include java

class { 'jboss':
  install => 'source',
  version => '7',
  bindaddr => '192.168.10.14'
 }

include jboss
include testweb
include iptables
}

