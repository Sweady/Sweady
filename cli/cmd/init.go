package cmd

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/fatih/color"
	"github.com/spf13/cobra"
	"io/ioutil"
	"os"
	"strings"
)

var initCmd = &cobra.Command{
	Use:   "init",
	Short: "Create new json file",
	Run: func(cmd *cobra.Command, args []string) {
		color.Green("Initialization of Sweady")

		if !askForConfirmation() {
			color.Yellow("Initialization cancelled")
			return
		}

		prettyConf, _ := json.Marshal(Init())
		prettyConf, _ = prettyJson(prettyConf)

		color.Green("Add sweady_config.json")
		err := ioutil.WriteFile("./sweady_config.json", prettyConf, 0644)
		if err != nil {
			color.Red(err.Error())
			os.Exit(1)
		}

		color.Green("Initialization completed")
		return
	},
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

func prettyJson(b []byte) ([]byte, error) {
	var out bytes.Buffer
	err := json.Indent(&out, b, "", "  ")
	return out.Bytes(), err
}

func init() {
	RootCmd.AddCommand(initCmd)
}
