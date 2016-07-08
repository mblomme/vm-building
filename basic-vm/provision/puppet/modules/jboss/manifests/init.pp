define jboss (
  $jboss_version          = '8.2.0.Final',
  $jboss_folder           = "wildfly",
  $jboss_install_dir      = "/opt",
  $jboss_user             = "wildfly",
  $jboss_service          = "wildfly",
  $jboss_startup          = 240,
  $jboss_shutdown         = 30,
  $jboss_service_conf     ="/etc/default/wildfly.conf",
  $jboss_mode             ="standalone",
  $jboss_config           ="standalone.xml",
  $download_dir           = "/home/vagrant/downloads/",
  
  ) {
    
   $jboss_dir = "${jboss_install_dir}/${jboss_folder}"

  jboss::install {"${name}.${extension}":
    jboss_version          => $jboss_version,         
	  jboss_folder           => $jboss_folder,          
	  jboss_install_dir      => $jboss_install_dir,     
	  jboss_user             => $jboss_user,            
	  jboss_service          => $jboss_service,         
	  download_dir           => $download_dir, 
	  jboss_dir              => $jboss_dir         
  }
  
   jboss::config {"${name}.${extension}":    
		  jboss_service_conf   => $jboss_service_conf,
		  jboss_home           => $jboss_dir,
		  jboss_user           => $jboss_user,
		  jboss_mode           => $jboss_mode,
		  jboss_config         => $jboss_config,
		  jboss_service        => $jboss_service,
		  jboss_startup        => $jboss_startup_timeout,
		  jboss_shutdown       => $jboss_shutdown_timeout          
  }
	
}