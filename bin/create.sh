#!/usr/bin/env bash
if [ "$1" == "scaleway" ]; then
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

    mkdir ../../tmp/
	echo [all] > ../../tmp/inventory_ansible_swarm
	echo [swarm_master] >> ../../tmp/inventory_ansible_swarm
	terraform output cluster_swarm_master >> ../../tmp/inventory_ansible_swarm
	echo [swarm_node] >> ../../tmp/inventory_ansible_swarm
	terraform output cluster_swarm_node >> ../../tmp/inventory_ansible_swarm
	echo [swarm_glusterfs] >> ../../tmp/inventory_ansible_swarm
	terraform output cluster_swarm_glusterfs >> ../../tmp/inventory_ansible_swarm

	ansible-playbook ./../../ansible/init.ansible.yaml -i ../../tmp/inventory_ansible_swarm
fi