class basic::setup {

	notice("Disabling firewall & SELinux")
	
	service { 'firewalld':
	    enable => false,
	}
	
}