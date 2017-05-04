package cmd

import "encoding/json"

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