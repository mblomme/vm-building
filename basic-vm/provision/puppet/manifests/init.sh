# UPDATE SYSTEM
sudo yum install -y

# INSTALL PUPPET
echo "Adding puppet repo"
sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

echo "installing puppet"
sudo yum install puppet -y

echo "ensure puppet service is running"
sudo puppet resource service puppet ensure=running enable=true

echo "ensure puppet service is running for standalone install"
sudo puppet resource cron puppet-apply ensure=present user=root minute=30 command='/usr/bin/puppet apply $(puppet apply --configprint manifest)'