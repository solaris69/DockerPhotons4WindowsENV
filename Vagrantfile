Vagrant.configure(2) do |config|

  config.vm.box = "vc_photon1.0.2TP2"
##  config.vm.box = "vmware/photon"
#  config.ssh.insert_key = 'true'
#  config.ssh.pty = true
  config.ssh.username = "root"
  config.ssh.password = "cpadm!n1"

  config.vm.provider "vmware_workstation" do |v|
#    v.gui = true
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "2"
    v.vmx["cpuid.coresPerSocket"] = "1"
  end
  config.vm.hostname = "docker-photon"
  config.vm.network "private_network", ip: "192.168.126.72", auto_config: false, :mac => "005056BCBA10"
  config.vm.provision "shell", path: "set_photon_static_ip.sh", args: ["00:50:56:BC:BA:10","192.168.126.72","24"]

#  config.vm.network "forwarded_port", guest: 80, host: 80
#The forwarded port to 80 is already in use on the host machine.

end
