# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: hosts
# ---
#
# Operating System Host Entry Management
#
# A wrapper around the {Puppet Host Resource}[http://docs.puppetlabs.com/references/3.stable/type.html#host] for managing operating system host entries via Hiera.
#
class hosts {

  # Define a minimim host standard config
  $minstandard = {

    # IPv4
    'localhost' => {
      'ip'            => '127.0.0.1',
      'host_aliases'  => [ 'localhost.localdomain' ],
      'comment'       => 'IPv4 loopback',
    },

    # IPv6
    'localhost6' => {
      'ip'            => '::1',
      'host_aliases'  => [
        'ip6-localhost',
        'ip6-loopback',
        'localhost6.localdomain6',
      ],
      'comment'       => 'IPv6 loopback'
    },

    'ip6-localnet'    => { 'ip'  => 'fe00::0' },
    'ip6-mcastprefix' => { 'ip'  => 'ff00::0' },
    'ip6-allnodes'    => { 'ip'  => 'ff02::1' },
    'ip6-allrouters'  => { 'ip'  => 'ff02::2' },
    'ip6-allhosts'    => { 'ip'  => 'ff02::3' },

    # Self
    "${::fqdn}" => {
      'ip'            => "${::ipaddress}",
      'host_aliases'  => [ "${::hostname}" ],
      'comment'       => 'self',
    },
  }

  # Load host entries via Hiera
  $newhosts = hiera_hash("${name}::add", {})

  # Merge the hiera hosts with the minimal standard
  #
  # NOTE: we use a custom deep merge function as puppetlabs has not yet
  # released an updated stdlib version which includes the deep_merge() function.
  #
  $allhosts = clabs_deep_merge($minstandard, $newhosts)

  clabs::module::init { $name: }

}

