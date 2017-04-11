package config

type Configuration struct {
	Header struct {
		Version string `json:"version"`
	} `json:"header"`
	Provider struct {
		Aws struct {
			AccessKey   string `json:"access_key" env:"access_key"`
			Ami         string `json:"ami" env:"ami"`
			AmiUser     string `json:"ami_user" env:"ami_user"`
			KeyName     string `json:"key_name" env:"key_name"`
			Region      string `json:"region" env:"region"`
			SecretKey   string `json:"secret_key" env:"secret_key"`
			SSHKey      string `json:"ssh_key" env:"ssh_key"`
			SwarmNodes  string `json:"swarm_nodes" env:"swarm_nodes"`
			TypeManager string `json:"type_manager" env:"type_manager"`
			TypeNode    string `json:"type_node" env:"type_node"`
		} `json:"aws"`
	} `json:"provider"`
	Component struct {
		Log        bool `json:"log" env:"log"`
		Monitoring bool `json:"monitoring" env:"monitoring"`
		Sweady     bool `json:"sweady" env:"sweady"`
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
