class basic::tools {

	notice("installing mandatory packages")
	
	notice("installing Vim")
	class { 'vim': }
	
	notice("install wget")
	package { "wget":
	  ensure => "installed",
	}

}

