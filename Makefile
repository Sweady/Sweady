.DEFAULT_GOAL := help

create: 	terraform-apply				## Create infrastructure, provider=aws
destroy: 	terraform-destroy			## Destroy infrastructure, provider=aws

terraform-apply:
	./bin/create.sh ${provider}

terraform-destroy:
	./bin/destroy.sh ${provider}

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf 	"\033[36m%-30s\033[0m %s\n", $$1, $$2}'
