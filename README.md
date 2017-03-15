# Sweady

# Install
Install all composant for run Sweady cluster.

## Launch Sweady for Scaleway

```BASH
make create provider=scaleway
```

## Launch Sweady for AWS

```BASH
make create provider=aws
```

## Launch Sweady for OpenStack

```BASH
make create provider=openstack
```

# Update
Si une modification est faite dans terraform, il faut utiliser la commande ```make update``` pour réaliser les updates de celui-ci.

## Update Sweady for Scaleway

```BASH
make update provider=scaleway
```

## Update Sweady for AWS

```BASH
make update provider=aws
```

## Update Sweady for OpenStack

```BASH
make update provider=openstack
```

# Destroy
Si vous souhaitez supprimer l'ensemble de votre cluster Sweady, il faut utiliser la commande ```make destroy```.
/!\ Attention, cela supprime l'ensemble des données ! Il faut réaliser vos sauvegarde si nécessaire avant /!\

## Destroy Sweady for Scaleway

```BASH
make destroy provider=scaleway
```

## Destroy Sweady for AWS

```BASH
make destroy provider=aws
```

## Destroy Sweady for OpenStack

```BASH
make destroy provider=openstack
```