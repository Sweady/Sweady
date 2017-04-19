package main

import (
	"./cmd"
)

var (
	VERSION = "0.0.1"
)

func main() {
	cmd.Execute(VERSION)
}
