define jboss::interfaces (
  $jboss_home           = '/opt/wildfly',
  $jboss_mode           = "standalone",
  $jboss_config         = "standalone.xml",
  ) {
  
  augeas { "${name}.${extension}":
    lens    => "Xml.lns",
    incl    => "${jboss_home}/${jboss_mode}/configuration/${jboss_config}",
    changes => [
        "ins any-address after server/interfaces/interface[#attribute/name='${name}']/#text[1]",
        "rm server/interfaces/interface[#attribute/name='${name}']/inet-address",     
    ],
    onlyif  => [
        "match server/interfaces/interface[#attribute/name='${name}']/inet-address size == 1",
        "match server/interfaces/interface[#attribute/name='${name}']/any-address size == 0",
    ],
  }
}
