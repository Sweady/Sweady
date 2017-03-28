# Sweady

# Install
Install all composant for run Sweady cluster.

## AWS

```BASH
make create provider=aws
```

# Destroy
If you want to remove all of your Sweady cluster, use `` `make destroy```.   
<span style="color:red"> /!\ </span> Caution, this removes all data! It is necessary to carry out your backups if necessary before <span style="color:red"> /!\ </span>

## AWS

```BASH
make destroy provider=aws
```

# Use Docker 

## Install
 ```BASH
 docker run --rm -ti -v ~/.ssh:/root/.ssh -v $(pwd):/sweady sweady/sweady make create provider=aws
 ```
## Destroy
 ```BASH
 docker run --rm -ti -v ~/.ssh:/root/.ssh -v $(pwd):/sweady sweady/sweady make destroy provider=aws
 ```