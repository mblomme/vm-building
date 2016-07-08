class basic::tools {

	notice("installing mandatory packages")
	
	notice("Installing Vim")
	class { 'vim': }
	
	notice("Installing wget")
  include wget
  
}

