## opsource-gem

Dimension Data Cloud API gem designed for easy extensibility.

See `lib/dimensiondata/api` folder for examples how to add additional endpoints.


### Install

either install as a gem via Bundler

__or__

clone into your project, install gems from `opsource.gemspec` and do:

```
$: << 'dimensiondata/lib'
require 'dimensiondata.rb'
```

### Usage

```
api_base      = "https://cloudapi.nttamerica.com/oec/0.9"
dev_org_id    = 'my-super-secret-org-numbersandletters'
dev_user      = 'me'
dev_password  = 'very secret'

c = Dimensiondata::Client.new(api_base, user, password)

server = c.server.list(name: 'myfavoritevm')
pp c.server.show_with_disks(server.network_id, server.id)
```

### Examples

```
#create a new network
c.network.create("network-name", "NA3", "description")
#list networks
pp c.network.list

```


