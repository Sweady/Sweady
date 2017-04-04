package main

import (
	"./config"
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/urfave/cli"
	"io/ioutil"
	"os"
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

func initAction(c *cli.Context) error {
	prettyConf, _ := json.Marshal(config.Init())
	prettyConf, _ = prettyJson(prettyConf)

	err := ioutil.WriteFile("./sweady_config.json", prettyConf, 0644)
	check(err)

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

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func prettyJson(b []byte) ([]byte, error) {
	var out bytes.Buffer
	err := json.Indent(&out, b, "", "  ")
	return out.Bytes(), err
}
