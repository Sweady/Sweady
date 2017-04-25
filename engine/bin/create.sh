#!/usr/bin/env bash
if [ "$1" == "aws" ]; then

    if [ -f data/sweady.pub ]; then
        echo "SSH KEY is present."
    else
        echo "SSH KEY is not present."
        if [ ! -f data ]; then
            mkdir data
        fi
        ssh-keygen -t rsa -b 4096 -f data/sweady -q -N ""
    fi

    echo "Launch Terraform"
    cd provider/$1

	terraform validate
	terraform get
	terraform apply

    #Backup terraform.tfstate
    cp *.tfstate ./../../data/


    sleep 60

    # Launch Ansible
    platform=$(uname)
    if [[ $platform == 'Linux' ]]; then
        ansible-playbook ./../../ansible/init.ansible.yaml -i terraform-inventory-linux --private-key ../../data/sweady --user=ubuntu -e "efs_url=$(terraform output  mount_target_master_public_subnets_dns_name)"
    elif [[ $platform == 'Darwin' ]]; then
        ansible-playbook ./../../ansible/init.ansible.yaml -i terraform-inventory-darwin --private-key ../../data/sweady --user=ubuntu -e "efs_url=$(terraform output  mount_target_master_public_subnets_dns_name)"
    fi

fi