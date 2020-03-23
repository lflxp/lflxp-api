# lflxp-api
Using boltdb to quickly build the local key / value restful API for local monitoring, etc

![](https://github.com/lflxp/lflxp-api/blob/master/asset/b1.png)

# Requirements

* go get -u github.com/jteeuwen/go-bindata/...
* go get -u github.com/elazarl/go-bindata-assetfs/...
* go get -u github.com/swaggo/swag/cmd/swag

# Install

> make

There were two step in makefile

* cp cmd/main.go ..
* go build


`For Coder Demo`

> cmd/main.go

```go
package main

import (
	"flag"
	"github.com/lflxp/lflxp-api/pkg"
)

var (
	host string
	port string
	stats bool
)

func init() {
	flag.StringVar(&host,"host","127.0.0.1","bind http host")
	flag.StringVar(&port,"port","8080","bind http port")
	flag.BoolVar(&stats,"stats",false,"is output db stats")
	flag.Parse()
}

func main() {
	api := pkg.Apis{
		Host:host,
		Port:port,
		Stats: stats,
	}

	err := api.Check()
	if err != nil {
		panic(err)
	}

	api.Execute()
}
```

# Running

`Format`

```bash
➜  lflxp-api git:(master) ✗ lflxp-api -h
Usage of lflxp-api:
  -host string
        bind http host (default "127.0.0.1")
  -port string
        bind http port (default "8080")
  -stats
        is output db stat
```

> lflxp-api -stats 

Open http://127.0.0.1:8080 in browser

# Prefix interface
![](https://github.com/lflxp/lflxp-api/blob/master/asset/b2.png)

It mainly provides basic operation functions, including:

* Bucket query, add, delete

* Bucket key and value display

* Key deletion and modification function

* Prefix query

* Paging function

* Refresh function 

# Range interface

The only difference from the prefix interface is the search function, including:

* Query by key time range

* The time data is an array of [min, Max], eg: ["20200313000000", "20200412235959"]

* The time format is: ` yyyymmddhhmmss`

# Orm

Todo: time series field retrieval based on value

# Backup

Provide HTTP backup data function

# Swagger

Visual interface of API based on gin swagger

![](https://github.com/lflxp/lflxp-api/blob/master/asset/b3.png)

# Making data

> while true;do curl -X POST "http://127.0.0.1:8080/api/v1/key/add/monitor/$RANDOM/$RANDOM" -H "accept: application/json";done