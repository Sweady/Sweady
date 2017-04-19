package cmd

import (
	"encoding/json"
	"github.com/fatih/color"
	"github.com/spf13/cobra"
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

		color.Green("Creation of environnement file")
		generateEnvFile(jsontype)

		color.Green("Starting cluster")

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

func generateEnvFile(obj interface{}) interface{} {
	original := reflect.ValueOf(obj)
	copy := reflect.New(original.Type()).Elem()

	file, _ := os.Create(".env")
	writeEnvFile(copy, original, file)
	file.Sync()

	return copy.Interface()
}

func writeEnvFile(copy, original reflect.Value, file *os.File) {

	switch original.Kind() {

	case reflect.Struct:
		for i := 0; i < original.NumField(); i += 1 {

			if original.Type().Field(i).Tag.Get("env") != "" && original.Field(i).String() != "" {
				val := original.Field(i)
				switch val.Kind() {
				case reflect.Bool, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64:
					value := strconv.FormatBool(val.Bool())
					file.WriteString(original.Type().Field(i).Tag.Get("env") + "=" + value + "\n")
				case reflect.String:
					file.WriteString(original.Type().Field(i).Tag.Get("env") + "=" + val.String() + "\n")
				default:
				}
			}
			writeEnvFile(copy.Field(i), original.Field(i), file)
		}
	default:
		copy.Set(original)
	}
}

func init() {
	RootCmd.AddCommand(createCmd)
}
