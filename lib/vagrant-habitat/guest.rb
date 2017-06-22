require "vagrant-habitat/guest/version"
require 'vagrant'

module VagrantPlugins
  module GuestHabitat
    class Guest < Vagrant.plugin("2", :guest)
      def detect?(machine)
        #machine.communicate.test("test -f /etc/hab-release")
        true
      end
    end
  end
end
