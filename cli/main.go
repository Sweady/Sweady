package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/fatih/color"
	"github.com/urfave/cli"
	"io/ioutil"
	"os"
	"strings"
)

func main() {
	app := cli.NewApp()
	app.Name = "Sweady"
	app.Usage = "First cluster docker swarm ready for production"
	app.Version = "0.1.0"

	app.Commands = []cli.Command{
		{
			Name:     "init",
			Usage:    "Initialization of template",
			Category: "Sweady",
			Action:   initAction,
		},
		{
			Name:     "create",
			Usage:    "Create sweady prod cluster",
			Category: "Sweady",
			Action:   createAction,
		},
	}

	app.Run(os.Args)
}

func initAction(*cli.Context) error {
	color.Green("Initialization of Sweady")

	if !askForConfirmation() {
		color.Yellow("Initialization cancelled")
		return nil
	}

	prettyConf, _ := json.Marshal(Init())
	prettyConf, _ = prettyJson(prettyConf)

	color.Green("Add sweady_config.json")
	err := ioutil.WriteFile("./sweady_config.json", prettyConf, 0644)
	if err != nil {
		return cli.NewExitError(err.Error(), 86)
	}

	color.Green("Initialization completed")
	return nil
}

func createAction(*cli.Context) error {
	color.Green("Welcome with Sweady")
	dat, err := ioutil.ReadFile("./sweady_config.json")
	if err != nil {
		return cli.NewExitError(err.Error(), 86)
	}
	color.Green("Config found [OK]")

	var jsontype Configuration
	json.Unmarshal(dat, &jsontype)
	var i ValidatorInterface = JsonValidator{string(dat)}
	if i.IsValid() {
		color.Green("Config syntax [OK]")
	} else {
		return cli.NewExitError("Config syntax [KO]", 86)
	}

	color.Green("Creation of environnement file")
	generateEnvFile(jsontype)

	color.Green("Starting cluster")

	return nil
}

func prettyJson(b []byte) ([]byte, error) {
	var out bytes.Buffer
	err := json.Indent(&out, b, "", "  ")
	return out.Bytes(), err
}

func askForConfirmation() bool {
	var s string

	color.Yellow("Are you sure ? (y/N): ")
	_, err := fmt.Scan(&s)
	if err != nil {
		panic(err)
	}

	s = strings.TrimSpace(s)
	s = strings.ToLower(s)

	if s == "y" || s == "yes" {
		return true
	}
	return false
}
