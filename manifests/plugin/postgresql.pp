# https://collectd.org/wiki/index.php/Plugin:PostgreSQL
class collectd::plugin::postgresql (
  $ensure = present,
  $databases = [],
  $queries = [],
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_array($databases, $queries)

  file { 'postgresql.conf':
    ensure => $ensure,
    path => "${conf_dir}/postgresql.conf",
    mode => '0644',
    owner => 'root',
    group => 'root',
    content => template('collectd/postgresql.conf.erb'),
    notify => Service['collectd'],
  }
}