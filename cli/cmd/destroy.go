package cmd

import (
	"encoding/json"
	"github.com/fatih/color"
	"github.com/spf13/cobra"
	"../docker"
	"io/ioutil"
	"os"
)

var destroyCmd = &cobra.Command{
	Use:   "destroy",
	Short: "Destroy sweady cluster",
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
		_, err = docker.ImagePull("sweady/build:latest")

		color.Green("Destroying cluster")
		docker.ContainerCreate(
			"sweady/build:latest",
			GenerateEnv(jsontype),
			[]string{"make", "destroy", "provider=aws"},
			jsontype.Header.DataDir,
			true)
		return
	},
}

func init() {
	RootCmd.AddCommand(destroyCmd)
}