#!/usr/bin/env bash
if [ "$1" == "aws" ]; then
    echo "Launch Terraform"
    cd provider/$1

	terraform validate
	terraform get
	terraform apply

    sleep 60

    platform=$(uname)
    if [[ $platform == 'Linux' ]]; then
        ansible-playbook ./../../ansible/init.ansible.yaml -i terraform-inventory-linux --private-key ~/.ssh/aws.pem --user=ubuntu -e "efs_url=$(terraform output  mount_target_master_public_subnets_dns_name)"
    elif [[ $platform == 'Darwin' ]]; then
        ansible-playbook ./../../ansible/init.ansible.yaml -i terraform-inventory-darwin --private-key ~/.ssh/aws.pem --user=ubuntu -e "efs_url=$(terraform output  mount_target_master_public_subnets_dns_name)"
    fi
fi