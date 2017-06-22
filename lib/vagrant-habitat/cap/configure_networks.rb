require 'ipaddr'

module VagrantPlugins
  module GuestHabitat
    module Cap
      class ConfigureNetworks
        def self.configure_networks(machine, networks)
          networks.each do |network|
            comm = machine.communicate
            ip_command = "/bin/hab pkg exec core/iproute2 ip"


            interfaces = machine.guest.capability(:network_interfaces, ip_command)

            networks.each do |network|
              # https://stackoverflow.com/questions/1825928/netmask-to-cidr-in-ruby
              cidr = IPAddr.new(network[:netmask]).to_i.to_s(2).count("1")
              
              network[:device] = interfaces[network[:interface]]

              if network[:type].to_sym == :static
                comm.sudo("#{ip_command} addr add #{network[:ip]} dev #{network[:device]}")
                comm.sudo("ifconfig #{network[:device]} up")
                comm.sudo("#{ip_command} route add #{IPAddr.new(network[:ip]).mask(cidr)}/#{cidr} dev #{network[:device]}")
              end
            end
            

            # device = "#{machine.config.solaris.device}#{network[:interface]}"
            # su_cmd = machine.config.solaris.suexec_cmd
            # ifconfig_cmd = "#{su_cmd} /sbin/ifconfig #{device}"

            # machine.communicate.execute("#{ifconfig_cmd} plumb")

            # if network[:type].to_sym == :static
            #   machine.communicate.execute("#{ifconfig_cmd} inet #{network[:ip]} netmask #{network[:netmask]}")
            #   machine.communicate.execute("#{ifconfig_cmd} up")
            #   machine.communicate.execute("#{su_cmd} sh -c \"echo '#{network[:ip]}' > /etc/hostname.#{device}\"")
            # elsif network[:type].to_sym == :dhcp
            #   machine.communicate.execute("#{ifconfig_cmd} dhcp start")
            # end
          end
        end
      end
    end
  end
end
