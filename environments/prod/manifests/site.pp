class nginx {
  package { 'nginx':
    ensure => 'installed'
  }
  notify { 'Nginx is installed.':
  }
  service { 'nginx':
    ensure => 'running'
  }
  notify { 'Nginx is running.':
  }
}
include nginx


include '::mysql::server'
mysql::db { 'prod_mdb':
user => 'prod_user',
password => 'mypass',
host => 'localhost',
grant => ['ALL'],
}

