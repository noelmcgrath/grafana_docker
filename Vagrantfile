Vagrant.configure("2") do |config|
	config.vm.box = "dockerNoel"
	config.vm.box_url = "http://files.vagrantup.com/precise64.box"
	config.vm.provider :virtualbox do |virtualbox|
        # allocate 1024 mb RAM
        virtualbox.customize ["modifyvm", :id, "--memory", "2048"] 
        # allocate max 50% CPU
        virtualbox.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
      end
	# we'll forward the port 8000 from the VM to the port 8000 on the host (OS X)
	config.vm.network :forwarded_port, host: 80, guest: 80
	config.vm.network :forwarded_port, host: 8000, guest: 8000
	config.vm.network :forwarded_port, host: 8080, guest: 8080
	config.vm.network :forwarded_port, host: 8125, guest: 8125, protocol: 'udp'
	config.vm.network :forwarded_port, host: 8126, guest: 8126
	config.vm.network :forwarded_port, host: 9200, guest: 9200
	config.vm.network :forwarded_port, host: 9300, guest: 9300

	config.vm.provision "docker"
end
