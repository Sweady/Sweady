package docker

import (
	"github.com/docker/docker/client"
)

var dockerClient *client.Client

func init() {
	dockerClient, _ = client.NewEnvClient()
}