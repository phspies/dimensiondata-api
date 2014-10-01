## dimensiondata-gem

Dimension Data Cloud API gem designed for easy extensibility.

See `lib/dimensiondata/api` folder for examples how to add additional endpoints.


### Install

either install as a gem via Bundler

__or__

clone into your project, install gems from `dimensiondata.gemspec` and do:

```
$: << 'dimensiondata/lib'
require 'dimensiondata.rb'
```

### Usage

```
c = Dimensiondata::Client.new("https://api-na.dimensiondata.com", "adminuser", "secret")

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


