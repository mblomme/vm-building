define jboss::config (
  $jboss_service_conf      ="/etc/default/wildfly.conf",
  $jboss_home             = '/opt/wildfly',
  $jboss_user             = "wildfly",
  $jboss_mode             = "standalone",
  $jboss_config           = "standalone.xml",
  $jboss_service          = "wildfly",
  $jboss_startup          = 240,
  $jboss_shutdown         = 30,
  ) {
  
  file { $jboss_service_conf :
	  ensure  => file,
	  content => template('jboss/wildfly.conf.erb'),
  }

  jboss::interfaces{'public':
    jboss_home    => $jboss_home,
    jboss_mode    => $jboss_mode,
    jboss_config  => $jboss_config,
   }
     
   jboss::interfaces{'management':
    jboss_home    => $jboss_home,
    jboss_mode    => $jboss_mode,
    jboss_config  => $jboss_config,
   }
   
   # set timeout
   augeas { "${name}.${extension}":
	    lens    => "Xml.lns",
	    incl    => "${jboss_home}/${jboss_mode}/configuration/${jboss_config}",
	    changes => "set server/*/*/deployment-scanner/#attribute/deployment-timeout $jboss_startup",
	    onlyif  => "match server/*/deployment-scanner[#attribute/deployment-timeout='${jboss_startup}'] size == 0",
  }
  
   # Replace MaxPermSize with MaxMetaspaceSize
   ## build a standalone.conf template file + defin
  

}
