package config

import (
	"testing"
)

func TestCorrectJSON (t *testing.T) {
	str := `{"page": 1, "fruits": ["apple", "peach"]}`
	var i ConfValidatorInterface = JsonValidator{string(str)}

	actualResult := i.IsValid()
	expectedResult := true

	if (actualResult != expectedResult){
		t.Fatalf("Expected %s but got %s", expectedResult, actualResult)
	}
}

func TestNotCorrectJSON (t *testing.T) {
	str := `{"page": 1 "fruits": ["apple", "peach"]}`
	var i ConfValidatorInterface = JsonValidator{string(str)}

	actualResult := i.IsValid()
	expectedResult := false

	if (actualResult != expectedResult){
		t.Fatalf("Expected %s but got %s", expectedResult, actualResult)
	}
}