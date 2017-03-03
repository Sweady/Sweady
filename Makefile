.DEFAULT_GOAL := help

create: 	terraform-apply				## Create infrastructure, provider=aws or scaleway
destroy: 	terraform-destroy			## Destroy infrastructure, provider=aws or scaleway

terraform-apply:
	./bin/create.sh ${provider}

terraform-destroy:
	terraform destroy
	rm -rf swarm.token
	rm -rf inventory_ansible_swarm
	rm -rf *.tfstate*
	rm -rf *.retry

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf 	"\033[36m%-30s\033[0m %s\n", $$1, $$2}'
