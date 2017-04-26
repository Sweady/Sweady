package cmd

import (
	"context"
	"encoding/json"
	"fmt"
	dockType "github.com/docker/docker/api/types"
	"github.com/docker/docker/api/types/container"
	"github.com/docker/docker/api/types/mount"
	"github.com/docker/docker/api/types/network"
	"github.com/docker/docker/client"
	"github.com/fatih/color"
	"github.com/spf13/cobra"
	"io"
	"io/ioutil"
	"os"
	"reflect"
	"strconv"
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

		color.Green("Starting cluster")
		launchDocker(generateEnv(jsontype), "sweady/build:latest", []string{"make", "create", "provider=aws"}, jsontype.Header.DataDir)
		return
	},
}

type ValidatorInterface interface {
	IsValid() bool
}

type JsonValidator struct {
	S string
}

func (j JsonValidator) IsValid() bool {
	var js map[string]interface{}
	return json.Unmarshal([]byte(j.S), &js) == nil
}

func generateEnv(obj interface{}) []string {
	original := reflect.ValueOf(obj)
	copy := reflect.New(original.Type()).Elem()

	var a []string
	writeEnv(copy, original, &a)

	return a
}

func writeEnv(copy, original reflect.Value, a *[]string) {

	switch original.Kind() {

	case reflect.Struct:
		for i := 0; i < original.NumField(); i += 1 {
			if original.Type().Field(i).Tag.Get("env") != "" && original.Field(i).String() != "" {
				val := original.Field(i)
				switch val.Kind() {
				case reflect.Bool, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64:
					value := strconv.FormatBool(val.Bool())
					*a = append(*a, original.Type().Field(i).Tag.Get("env")+"="+value)
				case reflect.String:
					*a = append(*a, original.Type().Field(i).Tag.Get("env")+"="+val.String())
				default:
				}
			}
			writeEnv(copy.Field(i), original.Field(i), a)
		}

	default:
		copy.Set(original)
	}
}

func init() {
	RootCmd.AddCommand(createCmd)
}

func launchDocker(env []string, image string, cmd []string, dir string) {
	cli, err := client.NewEnvClient()
	if err != nil {

		panic(err)
	}

	rc, err := cli.ImagePull(context.Background(), image, dockType.ImagePullOptions{})

	_, err = io.Copy(ioutil.Discard, rc)
	if err != nil {
		panic(err)
	}

	err = rc.Close()
	if err != nil {
		panic(err)
	}

	resp, err := cli.ContainerCreate(context.Background(),
		&container.Config{
			Image: image,
			Env:   env,
			Cmd:   cmd,
		},
		&container.HostConfig{
			AutoRemove: true,
			Mounts: []mount.Mount{
				{
					Type:   mount.TypeBind,
					Source: dir,
					Target: "/sweady/data",
				},
			},
		},
		&network.NetworkingConfig{},
		"sweady")
	if err != nil {
		fmt.Println(err)
	}

	if err := cli.ContainerStart(context.Background(), resp.ID, dockType.ContainerStartOptions{}); err != nil {
		fmt.Println(err)
	}
}
