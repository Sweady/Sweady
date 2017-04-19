package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
	"os"
)

var (
	VERSION string
)

var RootCmd = &cobra.Command{
	Use:   "sweady",
	Short: "First cluster docker swarm ready for production",
}

func Execute(version string) {
	VERSION = version

	if err := RootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(-1)
	}
}
