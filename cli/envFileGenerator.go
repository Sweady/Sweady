package main

import (
	"os"
	"reflect"
	"strconv"
)

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
