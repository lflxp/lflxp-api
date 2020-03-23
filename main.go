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