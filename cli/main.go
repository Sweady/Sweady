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
	"reflect"
	"strconv"
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
			Name:        "create",
			Description: "Create sweady prod cluster",
			Category:    "Sweady",
			Action:      createAction,
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

func createAction(*cli.Context) error {
	color.Green("Welcome with Sweady")
	dat, err := ioutil.ReadFile("./sweady_config.json")
	if err != nil {
		return cli.NewExitError(err.Error(), 86)
	}
	color.Green("Config found [OK]")

	var jsontype config.Configuration
	json.Unmarshal(dat, &jsontype)

	generateEnvFile(jsontype)

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

func generateEnvFile(obj interface{}) interface{} {
	original := reflect.ValueOf(obj)
	copy := reflect.New(original.Type()).Elem()

	file, _ := os.Create("sweady.env")
	readRecursive(copy, original, file)
	file.Sync()

	return copy.Interface()
}

func readRecursive(copy, original reflect.Value, file *os.File) {

	switch original.Kind() {

	case reflect.Struct:
		for i := 0; i < original.NumField(); i += 1 {

			if original.Type().Field(i).Tag.Get("env") != "" && original.Field(i).String() != "" {
				val := original.Field(i)
				switch val.Kind() {
				case reflect.Bool, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64:
					value := strconv.FormatBool(val.Bool())
					_, _ = file.WriteString(original.Type().Field(i).Tag.Get("env") + "=" + value + "\n")

				default:
					value := val.String()
					_, _ = file.WriteString(original.Type().Field(i).Tag.Get("env") + "=" + value + "\n")
				}
			}

			readRecursive(copy.Field(i), original.Field(i), file)
		}
	default:
		copy.Set(original)
	}
}
