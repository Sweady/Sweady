package config

type Configuration struct {
	Header struct {
		Version string `json:"version"`
	} `json:"header"`
	Provider struct {
		Aws struct {
			AccessKey   string `json:"access_key"`
			Ami         string `json:"ami"`
			AmiUser     string `json:"ami_user"`
			KeyName     string `json:"key_name"`
			Region      string `json:"region"`
			SecretKey   string `json:"secret_key"`
			SSHKey      string `json:"ssh_key"`
			SwarmNodes  string `json:"swarm_nodes"`
			TypeManager string `json:"type_manager"`
			TypeNode    string `json:"type_node"`
		} `json:"aws"`
	} `json:"provider"`
	Component struct {
		Log        bool `json:"log"`
		Monitoring bool `json:"monitoring"`
		Sweady     bool `json:"sweady"`
	} `json:"component"`
}

func Init() *Configuration {
	c := &Configuration{}
	c.Header.Version = "v0.1.0"
	c.Component.Log = true
	c.Component.Monitoring = true
	c.Component.Sweady = true
	return c
}
