class basic::setup {

	notice("Disabling firewall & SELinux")
	
	service { 'iptables':
	    enable => false,
	}
	
	service { 'ip6tables':
	    enable => false,
	}
}