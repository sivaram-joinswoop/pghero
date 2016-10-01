Vagrant.configure("2") do |config|
  config.vm.define "xenial" do |c|
    c.vm.box = "ubuntu/xenial64"
    c.vm.network "forwarded_port", guest: 3001, host: 3001
    c.vm.provision "shell", inline: <<-SCRIPT
wget -qO - https://deb.packager.io/key | sudo apt-key add -
echo "deb https://deb.packager.io/gh/pghero/pghero xenial master" | sudo tee /etc/apt/sources.list.d/pghero.list
sudo apt-get update
sudo apt-get -y install pghero
sudo pghero config:set PORT=3001
sudo pghero config:set DATABASE_URL=postgres://10.0.2.2/pghero_test
sudo pghero scale web=1
sudo service pghero restart
    SCRIPT
  end

  config.vm.define "jessie" do |c|
    c.vm.box = "debian/jessie64"
    c.vm.network "forwarded_port", guest: 3002, host: 3002
    c.vm.provision "shell", inline: <<-SCRIPT
wget -qO - https://deb.packager.io/key | sudo apt-key add -
echo "deb https://deb.packager.io/gh/pghero/pghero jessie master" | sudo tee /etc/apt/sources.list.d/pghero.list
sudo apt-get update
sudo apt-get -y install pghero
sudo pghero config:set PORT=3002
sudo pghero config:set DATABASE_URL=postgres://10.0.2.2/pghero_test
sudo pghero scale web=1
sudo service pghero restart
    SCRIPT
  end
end
