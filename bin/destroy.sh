#!/usr/bin/env bash

if [ "$1" == "scaleway" ] || [ "$1" == "aws" ]; then
    cd terraform/$1
    terraform destroy
fi