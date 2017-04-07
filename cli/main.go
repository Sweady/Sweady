package main

import (
	"./config"
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

	app.Commands = []cli.Command{
		{
			Name:        "init",
			Description: "Initialization of template",
			Category:    "Sweady",
			Action:      initAction,
		},
		{
			Name:        "start",
			Description: "Start sweady prod cluster",
			Category:    "Sweady",
			Action:      startAction,
		},
	}

	app.Run(os.Args)
}

func initAction(c *cli.Context) error {

	color.Green("Initialization of Sweady")

	if !askForConfirmation() {
		color.Yellow("Initialization cancelled")
		return nil
	}

	prettyConf, _ := json.Marshal(config.Init())
	prettyConf, _ = prettyJson(prettyConf)

	color.Green("Add sweady_config.json")
	err := ioutil.WriteFile("./sweady_config.json", prettyConf, 0644)
	if err != nil {
		return cli.NewExitError(err.Error(), 86)
	}

	color.Green("Initialization completed")
	return nil
}

func startAction(c *cli.Context) error {

	color.Green("Welcome with Sweady")
	dat, err := ioutil.ReadFile("./sweady_config.json")
	if err != nil {
		return cli.NewExitError(err.Error(), 86)
	}
	color.Green("Config found [OK]")

	var i config.ConfValidatorInterface = config.JsonValidator{string(dat)}
	if i.IsValid() {
		color.Green("Config syntax [OK]")
	} else {
		return cli.NewExitError("Config syntax [KO]", 86)
	}

	color.Green("Creation of environnement file")
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
