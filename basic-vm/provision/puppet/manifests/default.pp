# Default puppet manifest

# mandatory packages
notify{"INSTALLING MANDATORY PACKAGES":}
notify{"Installing: vim":}
class { 'vim': }

notify{"Installing: wget":}
package { "wget":
  ensure => "installed",
}
