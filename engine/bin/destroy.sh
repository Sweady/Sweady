#!/usr/bin/env bash

if [ "$1" == "aws" ]; then
    cd provider/$1
    cp ./../../data/*.tfstate .
    terraform destroy -force
fi