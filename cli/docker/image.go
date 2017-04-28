package docker

import (
	"io"
	"io/ioutil"
	"context"
	dockType "github.com/docker/docker/api/types"
)

type Image struct {
	ID          string   `json:"id"`
	Slug        string   `json:"slug"`
	RepoTags    []string `json:"repo_tags"`
	Size        int64    `json:"size"`
	VirtualSize int64    `json:"virtual_size"`
	Status      string   `json:"status"`
}

func ImagePull(image string) (Image, error) {

	rc, err := dockerClient.ImagePull(context.Background(), image, dockType.ImagePullOptions{})
	if err != nil {
		return Image{}, err
	}

	defer rc.Close()

	io.Copy(ioutil.Discard, rc)

	return ImageSerialize(image)
}

func ImageSerialize(imageID string) (Image, error) {

	dockInspect, _, err := dockerClient.ImageInspectWithRaw(context.Background(), imageID)
	img := Image{
		ID:          dockInspect.ID,
		RepoTags:    dockInspect.RepoTags,
		Size:        dockInspect.Size,
		VirtualSize: dockInspect.VirtualSize,
		Status:      "complete",
	}
	if len(img.RepoTags) > 0 {
		img.Slug = img.RepoTags[0]
	}
	return img, err
}