variable "openstack_username" {
  description = "Openstack Username"
}

variable "openstack_password" {
  description = "Openstack Password"
}

variable "openstack_tenant_name" {
  description = "Openstack tenant name"
}

variable "openstack_auth_url" {
  description = "Openstack auth url"
}

variable "openstack_region" {
  description = "Openstack region"
}

variable "openstack_name_sshkey" {
  description = "Openstack name ssh key"
}

variable "scw_type_manager" {
  default     = "VC1M"
  description = "Scaleway type for Manager"
}

variable "scw_type_node" {
  default     = "VC1M"
  description = "Scaleway type for Node"
}

variable "scw_machine_user" {
  default     = "root"
  description = "User for machine"
}

variable "scw_ssh_key" {
  default     = "~/.ssh/id_rsa"
  description = "Scaleway SSH key"
}

variable "swarm_nodes" {
  default     = 1
  description = "Number of nodes in the cluster"
}

variable "scw_type_glusterfs" {
  default     = "VC1M"
  description = "Scaleway type for GlusterFS"
}

variable "swarm_glusterfs" {
  default     = 4
  description = "Number of glusterfs"
}
