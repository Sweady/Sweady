#!/usr/bin/env bash
if [ "$1" == "scaleway" ] || [ "$1" == "aws" ] || [ "$1" == "openstack" ]; then
    echo "Download Ansible Galaxy"
    ansible-galaxy install GoContainer.system-update            >> /dev/null 2>&1
	ansible-galaxy install AerisCloud.disk                      >> /dev/null 2>&1
	ansible-galaxy install GoContainer.glusterfs                >> /dev/null 2>&1
	ansible-galaxy install GoContainer.docker-local-persist     >> /dev/null 2>&1
    echo "Launch Terraform"
    cd terraform/$1

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

    if [ "$1" == "scaleway" ]; then
        ansible-playbook ./../../ansible/init.ansible.yaml -i ../../tmp/inventory_ansible_swarm --user=root
    fi
    if [ "$1" == "aws" ]; then
        ansible-playbook ./../../ansible/init.ansible.yaml -i ../../tmp/inventory_ansible_swarm --user=ubuntu
    fi
    if [ "$1" == "openstack" ]; then
        ansible-playbook ./../../ansible/init.ansible.yaml -i ../../tmp/inventory_ansible_swarm --user=cloud
    fi
fi