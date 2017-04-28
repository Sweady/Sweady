package docker

import (
	"fmt"
	"context"
	"github.com/docker/docker/api/types"
	"github.com/docker/docker/api/types/container"
	"github.com/docker/docker/api/types/mount"
	"github.com/docker/docker/api/types/network"
	"github.com/docker/docker/api/types/strslice"
)

func ContainerCreate(image string, env []string, cmd strslice.StrSlice, sourceDirectory string, start bool) (container.ContainerCreateCreatedBody, error) {
	resp, err := dockerClient.ContainerCreate(
		context.Background(),
		&container.Config{
			Image: image,
			Env:   env,
			Cmd:   cmd,
		},
		&container.HostConfig{
			AutoRemove: false,
			Mounts: []mount.Mount{
				{
					Type:   mount.TypeBind,
					Source: sourceDirectory,
					Target: "/sweady/data",
				},
			},
		},
		&network.NetworkingConfig{},
		"sweady")
	if err != nil {
		fmt.Println(err)
	}


	if err := ContainerStart(resp.ID); err != nil {
		return resp, err
	}


	return resp, err

}

func ContainerStart(containerId string) (error){
	err := dockerClient.ContainerStart(context.Background(), containerId, types.ContainerStartOptions{})
	return err
}