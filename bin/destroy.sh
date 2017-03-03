#!/usr/bin/env bash
if [ "$1" == "scaleway" ]; then
    cd terraform/$1
    terraform destroy
fi