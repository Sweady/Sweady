package cmd

type Configuration struct {
	Header struct {
		Version     string `json:"version"`
		Environment string `json:"environment"`
		DataDir     string `json:"data_dir"`
	} `json:"header"`
	Provider struct {
		Aws struct {
			AccessKey    string `json:"access_key" env:"TF_VAR_aws_access_key"`
			SecretKey    string `json:"secret_key" env:"TF_VAR_aws_secret_key"`
			Ami          string `json:"ami" env:"TF_VAR_aws_ami"`
			KeyName      string `json:"ssh_key" env:"TF_VAR_aws_ssh_key"`
			Region       string `json:"region"`
			SwarmNodes   string `json:"swarm_nodes" env:"TF_VAR_swarm_nodes"`
			SwarmManager string `json:"swarm_manager" env:"TF_VAR_swarm_manager"`
			TypeManager  string `json:"type_manager" env:"TF_VAR_aws_type_manager"`
			TypeNode     string `json:"type_node" env:"TF_VAR_aws_type_node"`
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
