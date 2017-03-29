#!/usr/bin/env bash

cd provider/$1

platform=$(uname)
if [[ $platform == 'Linux' ]]; then
    ansible-playbook ./../../tests/test.ansible.yaml -i terraform-inventory-linux --private-key ~/.ssh/aws.pem --user=ubuntu -e "efs_url=$(terraform output  mount_target_master_public_subnets_dns_name)"
elif [[ $platform == 'Darwin' ]]; then
    ansible-playbook ./../../tests/test.ansible.yaml -i terraform-inventory-darwin --private-key ~/.ssh/aws.pem --user=ubuntu -e "efs_url=$(terraform output  mount_target_master_public_subnets_dns_name)"
fi