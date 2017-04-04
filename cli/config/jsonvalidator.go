package config

import (
	"encoding/json"
)

type JsonValidator struct {
	S string
}

func (j JsonValidator) IsValid() bool {
	var js map[string]interface{}
	return json.Unmarshal([]byte(j.S), &js) == nil
}
