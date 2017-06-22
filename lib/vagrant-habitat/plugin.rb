require "vagrant"

module VagrantPlugins
  module GuestHabitat
    class Plugin < Vagrant.plugin("2")
      name "Habitat guest"
      description "Habitat guest support."

      guest(:habitat, :linux) do
        require_relative "guest"
        Guest
      end

      guest_capability(:habitat, :configure_networks) do
        require_relative "cap/configure_networks"
        Cap::ConfigureNetworks
      end

      guest_capability(:habitat, :change_host_name) do
        require_relative "cap/change_host_name"
        Cap::ChangeHostName
      end
    end
  end
end
