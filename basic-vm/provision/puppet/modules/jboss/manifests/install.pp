define jboss::install (
  $jboss_version          = '8.2.0.Final',
  $jboss_folder           = "wildfly",
  $jboss_install_dir      = "/opt",
  $jboss_user             = "wildfly",
  $jboss_service          = "wildfly",
  $download_dir           = "/home/vagrant/downloads/",
  $jboss_dir              = "/opt/wildfly"
  ) {
  
  # PARAM SETUP
  $jboss_filename = "wildfly-${jboss_version}"
  $jboss_archive_name = "${jboss_filename}.tar.gz"
  $jboss_download_url = "http://download.jboss.org/wildfly/${jboss_version}/${jboss_archive_name}"
  $jboss_full_dir = "${jboss_install_dir}/${jboss_filename}"

  # INSTALL
  file { $download_dir:
    ensure => 'directory',
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0777',
  }
  
  file { $jboss_full_dir:
    ensure => 'directory',
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0777',
  } 
  
  archive { $jboss_archive_name:
    path         => "/${download_dir}/${jboss_archive_name}",
    extract      => true,
    extract_path => $jboss_install_dir,
    source       => $jboss_download_url,
    cleanup      => true,
    require      => [File[$jboss_full_dir], File[$download_dir]] ,
    notify       => File["$jboss_dir"],
  }
  
  file { $jboss_dir:
    ensure    => 'link',
    target    => $jboss_full_dir,
    notify    => File["/etc/init.d/${jboss_service}"],
  }

  # INSTALL SERVICE
  file { "/etc/init.d/${jboss_service}":
    ensure => present,
    source => "${jboss_dir}/bin/init.d/wildfly-init-redhat.sh",
    mode   => '0750',
    notify    => User["$jboss_user"],
  }
  
  # SETUP JBOSS USER
  user { $jboss_user:
    ensure     => present,
    comment    => 'jboss user',
    managehome => false,
    notify     =>  Exec['jboss_chown'],
  }

  exec { 'jboss_chown':
    command => "/bin/chown -R ${jboss_user}:${jboss_user} ${jboss_dir}",
    notify  => Exec['jboss_chown_recur'],
  }

  exec { 'jboss_chown_recur': command => "/bin/chown -R ${jboss_user}:${jboss_user} ${jboss_dir}/", }
}
