# frozen_string_literal: true

initial_user = 'mheiber'
inital_setup_script = <<~SCRIPT
  apt update -qq &&
  apt install -y wget gpg-agent git &&
  install -m0700 -o root -g root -d /root/.gnupg &&
  id #{initial_user} || useradd -d /home/#{initial_user} -s /bin/bash -m -U -G sudo,adm,cdrom,dip #{initial_user}
SCRIPT

Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-23.10'
  config.vm.box_version = '202402.01.0'

  config.vm.provision 'shell',
                      inline: inital_setup_script,
                      privileged: true
end
