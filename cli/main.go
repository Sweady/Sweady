package main

import (
	"encoding/json"
	"os"

	"./config"
	"fmt"
	"github.com/urfave/cli"
	"io/ioutil"
)

func main() {
	app := cli.NewApp()

	app.Commands = []cli.Command{
		{
			Name:        "init",
			Description: "Initialization of template",
			Category:    "Sweady",
			Action:      initAction,
		},
		{
			Name:        "create",
			Description: "Create new sweady prod cluster",
			Category:    "Sweady",
			Action:      createAction,
		},
	}

	app.Run(os.Args)
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func initAction(c *cli.Context) error {

	var d config.Configuration

	var data1 = []byte(`{"header":{"version":"v0.1.0"}, "component":{"log":true,"monitoring":true,"sweady":true}}`)

	if e := json.Unmarshal(data1, &d); e != nil {
		fmt.Println("Error:", e)
	}

	b, err := json.Marshal(d)
	check(err)

	err1 := ioutil.WriteFile("./config.dist.json", b, 0644)
	check(err1)

	return nil
}

func createAction(c *cli.Context) error {

	fmt.Println("Initialization of template")
	dat, err := ioutil.ReadFile("./config.dist.json")
	if err != nil {
		fmt.Print(err)
	}

	var i config.ConfValidatorInterface = config.JsonValidator{string(dat)}
	if i.IsValid() {
		fmt.Print("Valid")
	} else {
		fmt.Print("Non valid")
	}

	return nil
}
