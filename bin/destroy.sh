#!/usr/bin/env bash

if [ "$1" == "scaleway" ] || [ "$1" == "aws" ] || [ "$1" == "openstack" ]; then
    cd terraform/$1
    terraform destroy
fi