node 'node1' {
  include '::mysql::server'

  mysql::db { 'test_mdb':
  user     => 'test_user',
  password => 'password',
  host     => 'localhost',
  grant    => ['ALL']
  }
}

