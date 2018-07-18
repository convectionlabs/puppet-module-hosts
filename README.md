# puppet-module-hosts

A wrapper around the [Puppet Host Resource](http://docs.puppetlabs.com/references/3.stable/type.html#host) for managing operating system host entries via Hiera.

## Requirements
---

- Puppet version 3 or greater with Hiera support
- Puppet Modules:

| OS Family      | Module |
| :------------- |:-------------: |
| ALL            | [clabs/core](https://bitbucket.org/convectionlabs/puppet-module-core)|

## Usage
---

Load the host class via Puppet code or ENC:

```puppet
include hosts
```

## Configuration
---

All configuration settings should be defined using Hiera.

### Minimum Hosts Standard

A standard/minimal hosts configuration is always present for convenience.

The follow shows the minimal standard in YAML format:

```yaml
hosts::add:
    'localhost':
        'ensure'        : 'present'
        'ip'            : '127.0.0.1'
        'host_aliases'  :
            - 'localhost.localdomain'
        'comment'       : '## IPv4 loopback'
    'localhost6':
        'ensure'        : 'present'
        'ip'            :
        'host_aliases'  :
            - 'ip6-localhost'
            - 'ip6-loopback'
            - 'localhost6.localdomain6'
        'comment'       : '## IPv6 loopback & friends'

    'ip6-localnet':
        'ensure'        : 'present'
        'ip'            : 'fe00::0'
    'ip6-mcastprefix':
        'ensure'        : 'present'
        'ip'            : 'ff00::0'
    'ip6-allnodes': 
        'ensure'        : 'present'
        'ip'            : 'ff02::1'
    'ip6-allrouters': 
        'ensure'        : 'present'
        'ip'            : 'ff02::2'
    'ip6-allhosts': 
        'ensure'        : 'present'
        'ip'            : 'ff02::3'

    %{::fqdn}:
        'ensure'        : 'present'
        'ip'            : %{::ipaddress}
        'host_aliases'  : 
            - %{::hostname}
        'comment'       : '## Other hosts, starting with myself'
```

### Example: Alter standard host entries

You may alter the the standard host entries as needed.

In the following example with [Hiera Deeper Merging](http://docs.puppetlabs.com/hiera/1/lookup_types.html#deep-merging-in-hiera--120) enabled:

- disable the localhost6 entry
- add an additional alias to a host while inheriting/preserving the remaining standard entries

Hiera config: __hosts/myhostname.yaml__

```yaml
hosts::add:
    'localhost6':
        'ensure' : 'absent'
    %{::hostname}:
        'host_aliases':
            - 'myalias.foo.com'
```

### Example: Adding a new host entry

In the following example:

- add an additional host entry
- preserve/inherit the remaining standard entries

```yaml
hosts::add:
    'mynewhost':
        'ip'            : '1.2.3.4'
        'host_aliases'  :
            - 'mynewhost.mydomain.com'
```

