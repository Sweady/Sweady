package cmd

import (
	"reflect"
	"strconv"
)

func GenerateEnv(obj interface{}) []string {
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
					*a = append(*a, original.Type().Field(i).Tag.Get("env") + "=" + value)
				case reflect.String:
					*a = append(*a, original.Type().Field(i).Tag.Get("env") + "=" + val.String())
				default:
				}
			}
			writeEnv(copy.Field(i), original.Field(i), a)
		}

	default:
		copy.Set(original)
	}
}

