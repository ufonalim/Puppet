class testweb {

include jboss

package { 'install_unzip':
  name => 'unzip',
  ensure => installed
  }
package { 'install_wget':
  name => 'wget',
  ensure => installed
  }

$app = testweb
$deploy_path = '/opt/jboss-as-7.1.1.Final/standalone/deployments'
$url = 'http://www.cumulogic.com/download/Apps/testweb.zip'
$temp_dir = '/tmp/jboss'

file { 'create_temp':
  path => "$temp_dir",
  ensure => 'directory',
  require => Package['install_unzip']
  }

exec { 'download_app':
  command => "/usr/bin/wget $url",
  cwd => "$temp_dir",
  creates => "$temp_dir/$app.zip",
  require => File['create_temp']
  }

exec { 'unzip_app':
  command => "/usr/bin/unzip $temp_dir/$app.zip",
  cwd => "$temp_dir",
  creates => "$temp_dir/$app",
  require => Exec['download_app']
  }

file { 'deploy_app':
  source => "$temp_dir/$app/$app.war",
  path => "$deploy_path/$app.war",
  ensure => 'file',
  require => Exec['unzip_app']
  }


file { "deploy_xml":
  source => "puppet:///modules/testweb/testweb.xml",
  mode => 0755,
  path => "$deploy_path/$app.xml",
  replace => true,
  require => File["deploy_app"],
  notify => Service['jboss']
  }

}

