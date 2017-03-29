.DEFAULT_GOAL := help

create: 	sweady-create				## Create infrastructure, provider=aws
destroy: 	sweady-destroy				## Destroy infrastructure, provider=aws
test:		sweady-test					## Test infrastructure, provider=aws

sweady-create:
	./bin/create.sh ${provider}

sweady-destroy:
	./bin/destroy.sh ${provider}

sweady-test:
	./bin/create.sh 	${provider}
	./bin/test.sh 		${provider}
	./bin/destroy.sh 	${provider}

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf 	"\033[36m%-30s\033[0m %s\n", $$1, $$2}'
