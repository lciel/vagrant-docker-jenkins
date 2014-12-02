# Host port of jenkins
HOST_PORT_JENKINS = 8888
# Workspace directory
JENKINS_WORKSPACE = nil
#JENKINS_WORKSPACE = "~/Dropbox/jenkins/data/"

# for use Docker 1.2.0
COREOS_CHANNEL = "beta"

VAGRANTFILE_API_VERSION = "2"

Dotenv.load

Vagrant.configure("2") do |config|

  # Setup resource requirements
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.gui = false

    # https://gist.github.com/stevepereira/41fb2818491ea35dad79
    v.check_guest_additions = false
    v.functional_vboxsf     = false
  end

  # CoreOS
  config.vm.box = "coreos-#{COREOS_CHANNEL}"
  config.vm.box_version = ">= 308.0.1"
  config.vm.box_url = "http://#{COREOS_CHANNEL}.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json"

  # Port Forwardings
  config.vm.network "forwarded_port", guest: 8080, host: HOST_PORT_JENKINS

  # need a private network for NFS shares to work
  config.vm.network "private_network", ip: "192.168.50.5"
  # NFS settings
  config.vm.synced_folder ".", "/app", id: "core", nfs: true, mount_options: ['nolock,vers=3,udp']
  if JENKINS_WORKSPACE
    config.vm.synced_folder JENKINS_WORKSPACE, "/opt/data", id: "core", nfs: true, mount_options: ['nolock,vers=3,udp']
  end

  # Setup the images when the VM is first
  config.vm.provision "shell", inline: <<-EOT
    # build jenkins container
    docker build -t lciel/jenkins /app/jenkins
    # install jdk to CoreOS (to use jenkins slave node)
    cd /home/core
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u71-b14/jdk-7u71-linux-x64.tar.gz"
    tar xzf jdk-7u71-linux-x64.tar.gz
    rm jdk-7u71-linux-x64.tar.gz
    mv jdk1.7.0_71 jdk
  EOT

  # Make sure the correct containers are running
  # every time we start the VM.
  config.vm.provision "shell", run: "always", inline: <<-EOT
    if [ ! $(docker ps -a -q | wc -l) -eq 0 ]; then
        docker stop $(docker ps -a -q)
        docker rm $(docker ps -a -q)
        echo "Clear docker containers"
    fi
  EOT
  unless JENKINS_WORKSPACE
    config.vm.provision "shell", run: "always", inline: <<-EOT
      if [ ! -e /opt ]; then
          mkdir /opt
      fi
      if [ ! -e /opt/data ];then
          ln -s /app/jenkins/data /opt/data
      fi
    EOT
  end
  config.vm.provision "shell", run: "always", inline: <<-EOT
    docker run -d --name jenkins -p 8080:8080 -v /opt/data:/jenkins lciel/jenkins
  EOT

end

