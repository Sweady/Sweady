#!/usr/bin/env bash
if [ "$1" == "aws" ]; then
    echo "Launch Terraform"
    cd provider/$1

	terraform validate
	terraform get
	terraform apply

    mkdir ../../tmp/ >> /dev/null 2>&1
	echo "[all]" > ../../tmp/inventory_ansible_swarm
	echo "[swarm_master]" >> ../../tmp/inventory_ansible_swarm
	terraform output cluster_swarm_master >> ../../tmp/inventory_ansible_swarm
	echo "[swarm_node]" >> ../../tmp/inventory_ansible_swarm
	terraform output cluster_swarm_node >> ../../tmp/inventory_ansible_swarm
	echo "[swarm_glusterfs]" >> ../../tmp/inventory_ansible_swarm
	terraform output cluster_swarm_glusterfs >> ../../tmp/inventory_ansible_swarm

    ansible-playbook ./../../ansible/init.ansible.yaml -i ../../tmp/inventory_ansible_swarm --private-key ~/.ssh/aws.pem --user=ubuntu -e 'disk=xvdb'
fi