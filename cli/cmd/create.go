package cmd

import (
	"encoding/json"
	"github.com/fatih/color"
	"github.com/spf13/cobra"
	"../docker"
	"io/ioutil"
	"os"
)

var createCmd = &cobra.Command{
	Use:   "create",
	Short: "Create sweady cluster",
	Run: func(cmd *cobra.Command, args []string) {
		color.Green("Welcome with Sweady")
		dat, err := ioutil.ReadFile("./sweady_config.json")
		if err != nil {
			color.Red(err.Error())
			os.Exit(1)
		}
		color.Green("Config found [OK]")

		var jsontype Configuration
		json.Unmarshal(dat, &jsontype)
		var i ValidatorInterface = JsonValidator{string(dat)}
		if i.IsValid() {
			color.Green("Config syntax [OK]")
		} else {
			color.Red("Config syntax [KO]")
			os.Exit(1)
		}

		color.Green("Downloading sweady image")
		_, _ = docker.ImagePull("sweady/build:v0.1.0")

		color.Green("Starting cluster")
		resp, err := docker.ContainerCreate(
			"sweady/build:v0.1.0",
			GenerateEnv(jsontype),
			[]string{"env"},
			jsontype.Header.DataDir,
			true)

		docker.ContainerStart(resp.ID)

		return
	},
}

func init() {
	RootCmd.AddCommand(createCmd)
}