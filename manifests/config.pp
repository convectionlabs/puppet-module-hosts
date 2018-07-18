# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: hosts::config
# ---
#
# Operating System Host Entry Management
#
# A wrapper around the {Puppet Host Resource}[http://docs.puppetlabs.com/references/3.stable/type.html#host] for managing operating system host entries via Hiera.
#
class hosts::config inherits hosts {

  # Create host entries by default
  $defaults = {
    ensure        => 'present',
    host_aliases  => [],  # Required param
  }

  create_resources('host', $allhosts, $defaults)

}

